#!/usr/bin/env kesh run

-- original: https://raw.githubusercontent.com/GoogleChromeLabs/jsvu/main/cli.js

os: import 'os'

inquirer: import 'inquirer'
update-notifier: import 'update-notifier'

pkg: import './package.json'
log: import './shared/log.js'
[ get-status, set-status(]: import './shared/status.js')

get-platform: () ->
    match os.platform()
        'darwin' -> 'mac'
        'win32' -> 'win'
        _ -> 'linux'

os-choices: [
    [ name: 'macOS 64-bit',     value: 'mac64'    ]
    [ name: 'macOS M1 64-bit',  value: 'mac64arm' ]
    [ name: 'Linux 32-bit',     value: 'linux32'  ]
    [ name: 'Linux 64-bit',     value: 'linux64'  ]
    [ name: 'Windows 32-bit',   value: 'win32'    ]
    [ name: 'Windows 64-bit',   value: 'win64'    ]
]

guess-os: () ->
    platform: get-platform()
    if platform = 'mac' then return 'mac64arm' if os.arch() = 'arm64' else 'mac64'
    
    -- Note: `os.arch()` returns the architecture of the Node.js process
    -- which does not necessarily correspond to the system architecture.
    -- Still, if the user runs a 64-bit version of Node.js, it’s safe to
    -- assume the underlying architecture is 64-bit as well.
    -- https://github.com/nodejs/node/issues/17036
    arch: '64' if os.arch().includes('64') else '32'
    "{ platform }{ arch }"

prompt-os: () ->
    inquirer.prompt [
        name: 'step'
        type: 'list'
        message: 'What is your operating system?'
        choices: os-choices
        default: guess-os()
    ]

engine-choices: [
    [
        name: 'Chakra/ChakraCore'
        value: 'chakra'
        checked: true
    ]
    [
        name: 'GraalJS'
        value: 'graaljs'
        checked: true
    ]
    [
        name: 'Hermes'
        value: 'hermes'
        checked: true
    ]
    [
        name: 'JavaScriptCore'
        value: 'javascriptcore'
        checked: true
    ]
    [
        name: 'QuickJS'
        value: 'quickjs'
        checked: true
    ]
    [
        name: 'SpiderMonkey'
        value: 'spidermonkey'
        checked: true
    ]
    [
        name: 'V8'
        value: 'v8'
        checked: true
    ]
    [
        name: 'V8 debug'
        value: 'v8-debug'
        checked: false
    ]
    [
        name: 'XS'
        value: 'xs'
        checked: true
    ]
]

prompt-engines: () ->
    inquirer.prompt [
        name: 'step'
        type: 'checkbox'
        message: 'Which JavaScript engines would you like to install?'
        choices: engine-choices
    ]

log.banner(pkg.version)

-- Warn if an update is available.
update-notifier([ pkg ]).notify()

-- Read the user configuration + CLI arguments, and prompt for any missing info.
status: get-status()

args: process.argv.slice(2)

loop args as arg
    if arg.starts-with('--os=')
        os: arg.split('=').1
        set status.os: guess-os() if os = 'default' else os
    
    else if arg.starts-with('--engines=')
        engines-arg: arg.split('=').1
        engines: if engines-arg = 'all'
            then engine-choices.filter(_.checked).map(_.value)
            else engines-arg.split(',')
        set status.engines: engines
    
    else if arg.includes('@')
        <engine, version>: arg.split('@')
        set status.engine: engine
        set status.version: version
    
    else
        wants-help: arg = '--help' or arg = '-h'
        if not wants-help then print.error "\nUnrecognized argument: { JSON.stringify(arg) }\n"
        
        print '[<engine>@<version>]'
        print "[--os=\{{ os-choices.map((choice) -> choice.value).join(',') },default\}]"
        print "[--engines=\{{ engine-choices.map((choice) -> choice.value).join(',') }\},…]"

        print "\nComplete documentation is online:"
        print 'https://github.com/GoogleChromeLabs/jsvu#readme'
        return

if status.os is #none
    set status.os: (await prompt-os()).step
    set-status(status)
else
    log.success("Read OS from config: status.os }")

-- The user provided a specific engine + version, e.g. `jsvu v8@7.2`.
if status.engine? and status.version?
    [ engine, version ]: status
    log.success("Read engine + version from CLI argument: engine } v{ version }")
    install-specific-engine-version: import './shared/install-specific-version.js'
    await install-specific-engine-version([ import("./engines/{ engine }/index.js")..., status ])
    return

-- The user wants to install or update engines, but we don’t know
-- which ones.
if status.engines is #none or status.engines.length = 0
    set status.engines: (await prompt-engines()).step
    if status.engines.length = 0 then log.failure('No JavaScript engines selected. Nothing to do…')
    set-status(status)
else
    log.success("Read engines from config: { status.engines.join(', ') }")

-- Install the desired JavaScript engines.
update-engine: import './shared/engine.js'
loop status.engines as engine
    await update-engine([ status, import("./engines/{ engine }/index.js")... ])
