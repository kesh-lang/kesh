# Examples

### Assignment and values

Variables and values are immutable by default (single assignment, value semantics).

```lua
answer: 42
```

### Equality

Using `:` as the assignment operator means `=` is free to be used as the equality operator, as it should be.

`=` represents strict equality, where both operands must be of the same type. `/=` (`≠`) represents strict inequality.

```lua
answer = 42    --> true (strict equality)
answer ≠ '42'  --> true (strict inequality)
```

Similarly, `~=` represents loose equality and `~/=` (`~≠`) loose inequality, with type coercion of operands.

```lua
answer ~= '42'  --> true (loose equality)
answer ~≠ '42'  --> false (loose inequality)
```

### Primitive types

There are five primitive types:

- Booleans
- Numbers
- Strings
- Symbols
- Nothing

Booleans and numbers are as described in [na](https://github.com/kesh-lang/na#primitive-values), except that numbers are [IEEE 754 double-precision 64-bit floating-point](https://en.wikipedia.org/wiki/Floating-point_arithmetic#IEEE_754:_floating_point_in_modern_computers) values due to the underlying ECMAScript runtime.

#### Strings

Single-quoted strings are literal (raw) strings.

Double-quoted strings support escape sequences, and interpolation, which is simply inline blocks evaluated within the string.

```lua
answer: "The answer is { 3 * 14 }"  --> 'The answer is 42'
greeting: "Hey, { joe.name }!"      --> 'Hey, Joe!'
```

#### Symbols

[Symbols](https://en.wikipedia.org/wiki/Symbol_(programming)) are human-readable immutable values that are guaranteed to be unique.

Symbols may be either named (global) or anonymous (secret). Anonymous symbols can have an optional string description.

```lua
global: @foo
secret: @('foo')

global = @foo      --> true
secret = @('foo')  --> false
```

#### Nothing

There must be a way to represent the absence of value. Instead of `null` or `undefined`, an empty tuple `()` represents [`#nothing`](#special-types).

### Composite types

Due to the underlying ECMAScript runtime, composite types are reference types. Once ECMAScript supports [immutable records and tuples](https://github.com/tc39/proposal-record-tuple), composite types will be value types by default, only becoming reference types if [marked as mutable](#mutation).

#### Collections

Similar to Lua's tables, collections are able to represent both linear values (array) and key-value fields (object).

Arrays are 0-indexed by default.

```lua
people: [  -- an array of objects
    [ name: 'Joe', age: 27 ]
    [ name: 'Jane', age: 30 ]
]
```

#### Tuples

Tuples are a much simpler, but very useful, data structure for grouping related values.

A tuple of only one value is equivalent to that value. An empty tuple is equivalent to [`#nothing`](#special-types).

```lua
nothing: ()      --> #nothing
something: (42)  --> 42

position: (lat: 40, lon: -77)
position.0    --> 40
position.lon  --> -77
```

A common use of tuples is to group multiple values as a [function](#functions)'s parameter/argument.

### Objects

Objects (collections of key-value fields) are an essential part of the language. As in ECMAScript, arrays are in fact objects with auto-indexed numeric keys, functions are objects, and primitive values are automatically upgraded to objects as needed.

In **kesh**, even [the unit type](#special-types) is an object.

#### Delegation

As a prototype-based language, there are no classes or inheritance, only objects and [delegation](https://en.wikipedia.org/wiki/Delegation_(object-oriented_programming)).

Delegation is achieved by applying an object (the prototype) to an object literal, similar to how a function is applied to a value.

```lua
primate: [
    hairy: true
]

human: primate [
    hairy: false  -- shadowed field
    walks: true
    talks: true
]

joe: human [
    name: 'Joe'
]
--> [ name: 'Joe', hairy: false, walks: true, talks: true ]
```

The bottom prototype is the unit type [`#nothing`](#special-types), an object that only ever returns itself.

Accessing a missing field will therefore not produce an error, but always return `#nothing`.

```lua
joe.foo.bar.baz
--> #nothing
```

#### Concatenation

An alternative to delegation is [concatenation](https://en.wikipedia.org/wiki/Prototype-based_programming#Concatenation) of objects.

This is achieved by using the spread operator `...` to copy the fields of an existing object.

```lua
joe: [
    ...primate
    ...human
    name: 'Joe'
]
```

### Blocks

Blocks have lexical scope, allow variable shadowing and return the value of the last evaluated expression.

This can be used to produce a value within a local scope.

```lua
a: 1

answer: {
    a: 3
    b: 14
    a * b  --> 42
}

answer  --> 42
a       --> 1
b       --> b is not defined
```

### Functions

Functions are first-class citizens with closure. All functions have an arity of 1. The argument can of course be a tuple.

Because a 1-tuple is equivalent to its value, a function may be applied to a single value without the use of parens.

Function application is right associative.

```lua
sum: (a, b) -> a + b

greet: (person) -> {
    greeting: 'Hey' if person.friend else 'Hello'
    "{ greeting }, { person.name }!"
}

sum(35, 7)  -- conceptually: sum (35, 7)
--> 42

greet human [ name: 'Joe', friend: true ]  -- equivalent to: greet(human([ … ]))
--> 'Hey, Joe!'
```

Note how an object is also a function (`human` in the example), returning a copy of the provided object with itself applied as the prototype.

#### Modifiers (decorators)

Modifiers are simply functions applied to values upon assignment, more like [Python's decorators](https://en.wikipedia.org/wiki/Python_syntax_and_semantics#Decorators) than [TypeScript's](https://www.typescriptlang.org/docs/handbook/decorators.html).

```lua
formatted: (pattern) -> (string) -> pattern.replace('%s', string)

logged: (function) -> (...arguments) -> {
    print "Applying { function.name } to { arguments.join(', ') }"
    result: function(...arguments)
    print "Result: { result }"
    result
}
```

```lua
greet: logged (name) -> {
    -- …
}

joe: [
    name: formatted('magnificent %s') 'Joe'
]

greet joe
--> 'Hey, magnificent Joe!'
```

#### Composition

Functions may be combined using the composition operators `>>` and `<<`.

```lua
square >> negate >> print  -- forward function composition
print << negate << square  -- backward function composition
```

#### Pipeline

Values may be piped into functions using the pipeline `|>` and placeholder `_` operators ([Hack pipes](https://github.com/js-choi/proposal-hack-pipes)).

```lua
answer: 20
    |> sum(_, 20)
    |> _ + 2
```

### Type system

**kesh** inherits TypeScript's gradual and structural type system, with certain differences.

#### Type definitions

There are no interfaces, only types.

```lua
#point: (x: #number, y: #number)        -- tuple

#strings: #string[]                     -- array

#result: #string | #strings             -- union

#colorful: [ color: #string ]           -- object
#circle: [ radius: #number ]
#colorful-circle: #colorful & #circle   -- intersection
```

#### Type conversion

To cast to a primitive type, simply apply the type to the value as if it was a function.

```lua
boolean: #boolean 42   --> true
number:  #number '42'  --> 42
string:  #string 42    --> '42'
```

#### Object types

An object type may also be used as a prototype, as it is both a type definition and a plain object.

```lua
#primate: [
    hairy: #boolean
]

#human: #primate [
    hairy: false  -- literal type
    name: #string
]

joe: #human [ name: 'Joe' ]

joe of #human
--> true

joe of #primate
--> true
```

#### Protocols

On the other hand, an object type could be just a type definition or [protocol](https://en.wikipedia.org/wiki/Protocol_(object-oriented_programming)).

```lua
#walker-talker: [
    walk: (meter: #number) -> #string
    talk: (words: #string) -> #string
]
```

#### Special types

The unit type is `#nothing`, a [special object](https://gist.github.com/joakim/dd598d9c6b783cd7641100bc70215e68) that only ever returns itself. The top type is `#anything` and the bottom type is `#never`.

- `#anything`
- `(something)`
- `#nothing`
- `#never`

### Conditionals

Everything is an expression.

Conditionals are either the traditional `if…then…else…` construct, the ternary `…if…else…` or the pattern-matching `match`.

```lua
traditional: if age < 13 then 'kid' else if age < 20 then 'teenager' else 'adult'

ternary: 'kid' if age < 13 else 'teenager' if age < 20 else 'adult'

default: 'kid' if age < 13   -- results in #nothing if the condition is false

pattern: match age
    | 0..12   -> 'kid'       -- range is inclusive
    | 13..<20 -> 'teenager'  -- range is exclusive
    | 20..    -> 'adult'     -- to infinity (and beyond)
```

### Operators

Logical operators use words.

```lua
not true
true and false
true or false
```

Arithmetic operators coerce their operands to `#number`.

```lua
true + true  --> 2
4 + '2'      --> 6
```

### Unpacking collections

Collection and tuple values may be unpacked on assignment. Objects keys must be referenced using dot notation.

```lua
[first, ...rest]: [1, 2, 3]  -- rest is an array
[.name, ...rest]: joe        -- rest is an object

(b2, a2): (a1, b1)  -- value swapping with tuples
```

This can also be done within the function's parameter as part of its definition (complex example).

```lua
open: (
    window: #window                -- type annotation of value
    options as [                   -- unpacking of collection (options is the external name)
        .title ? 'Untitled'        -- picked field, with a default value if missing
        size.width as w ? 100      -- aliasing from a path shortcut, with a default value
        size.height as h ? 200
        items: [intro, ...fields]  -- unpacking of array, with rest values
    ]: #options                    -- type annotation of the options value
) -> #nothing {
    -- values available within the block:
    -- window: main
    -- title: 'Untitled'
    -- w: 100
    -- h: 200
    -- intro: intro
    -- fields: [field1, field2]
}

open(window: main, options: [ items: [intro, field1, field2] ])
```

### Mutation

The `mutation` directive enables the `let` and `set` keywords to mutate variables and fields, and the `*` unary operator to mark collections as mutable.

```lua
#!kesh 2021 (mutation)

let mutable  -- mutable variable
set mutable: true

joe: *[ name: 'Joe' ]  -- mutable collection
set joe.name: 'Joseph'
```
