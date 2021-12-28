-- 1. imports
import module: 'module'

-- 2. type declarations
#foobar: [
    foo: #logic
    bar: #number
    baz: #text
]

-- 3. value declarations
foo: true
bar: 42
baz: 'hi'
qux: #foobar [foo, bar, baz]

-- 4. expressions
print foo if bar = 42 else baz

-- 5. exports
[#foobar, qux]
