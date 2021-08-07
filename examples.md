# Examples

Variables and values are immutable by default (single assignment, value semantics).

```lua
answer: 42
```

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

Collections are similar to Lua's tables, able to represent both linear values (arrays) and key-value pairs (objects). Arrays are 0-indexed by default.

```lua
people: [  -- an array of objects
    [name: 'Joe', age: 27]
    [name: 'Jane', age: 30]
]
```

**kesh** inherits TypeScript's gradual and structural type system, with some differences. For example, **kesh** uses zero-values for its primitive types (all "falsy" values).

```lua
boolean:  #boolean  --> false
number:   #number   --> 0
string:   #string   --> ''
```

Prototypal "inheritance" is achieved by applying an object (the prototype) to an object literal, similar to how a function is applied to a value.

The prototype can either be a plain object or an object type (as in the example below). An object type may still be used as a plain object in addition to a type, or it may be used solely as a [data type](https://en.wikipedia.org/wiki/Data_type#Composite_types) or [protocol/interface](https://en.wikipedia.org/wiki/Protocol_(object-oriented_programming)).

```lua
#person: [
    name: #string
    age: #number
]

joe: #person [name: 'Joe', age: 27]
```

Blocks return the value of the last evaluated expression. This can be used to produce a value within a local scope.

```lua
answer: {
    a: 3
    b: 14
    a * b  --> 42
}
answer  --> 42
```

Functions are first-class citizens. All functions take only 1 argument, which may be a tuple. Therefore, a function may be applied to a single value without parens. Typing is gradual and inferred.

```lua
times: (a: #number, b: #number) -> { a * b }

greet: (person: #person) -> {
    greeting: 'Hey' if person.friend else 'Hello'
    "{ greeting }, { person.name }!"
}

times(3, 14)
--> 42

greet #person [name: 'Joe', friend: true]
--> 'Hey, Joe!'
```

Collections and tuples may be unpacked on assignment, including as a function argument. A collection with _both_ ordered values and key-value pairs is considered an array.

```lua
[first, ...rest]: [1, 2, 3]  -- rest is an array
[.name, ...rest]: joe  -- rest is an object
[.dharma, ...rest]: [4, 8, 15, 16, 23, 42, dharma: true]  -- rest is an array of the ordered values

(a, b): (b, a)  -- value swapping with tuples
```

Unpacking may be used as part of a function signature.

```lua
open: (
    window: #window                -- typed parameter
    options as [                   -- unpacking of parameter (options is the external name only)
        .title ? 'Untitled'        -- picked field with a default value if missing
        size: [
            .width as w ? 100      -- aliasing and default value
            .height as h ? 200
        ]
        items: [intro, ...fields]  -- unpacking of array with rest values
    ]: #options                    -- type annotation of the options parameter
) -> {
    -- available identifiers:
    (window, title, w, h, intro, fields)
}

open(window: main, options: [items: [intro, field1, field2, …]])
```

Everything is an expression. Conditionals are either the usual `if…else…` construct, the ternary `…if…else…` or pattern-matching `match`.

```lua
old-school: if age < 13 {
    'kid'
}
else if age < 20 {
    'teenager'
}
else {
    'adult'
}

ternary: 'kid' if age < 13 else 'teenager' if age < 20 else 'adult'
default: 'kid' if age < 13  --> results in () if the condition is false

pattern: match age
    | 0..12   -> 'kid'       -- range is inclusive
    | 13..<20 -> 'teenager'  -- range is exclusive
    | 20..    -> 'adult'     -- to infinity (and beyond!)
```

The `mutation` directive enables the `let` and `set` keywords to mutate variables and fields, and the `*` operator to mark collections as mutable.

```lua
#!kesh 2021 (mutation)

let mutable: false  -- mutable variable
set mutable: true

joe: *[name: 'Joe']  -- mutable collection
set joe.name: 'Joseph'
```

Logical operators use words.

```lua
not true        --> false
true and false  --> false
true or false   --> true
```

The unit type is [`#nothing`](https://gist.github.com/joakim/dd598d9c6b783cd7641100bc70215e68). The top type is `#anything` and the bottom type is `#never`.

- `#anything`
- `(something)`
- `#nothing`
- `#never`
