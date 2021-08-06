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

The `mutation` directive enables the `let` and `set` keywords to mutate variables and fields, and the `*` operator to mark collections as mutable.

```lua
#!kesh 2021 (mutation)

let mutable: false  -- mutable variable
set mutable: true

joe: *[name: 'Joe']  -- mutable collection
set joe.name: 'Joseph'
```

Collections are similar to Lua's tables, and may be used as both linear arrays and associative objects.

```lua
people: [  -- an array of objects
    [name: 'Joe', age: 27]
    [name: 'Jane', age: 30]
]
```

Prototypal "inheritance" is achieved by applying an object (the prototype) to an object literal, similar to how a function is applied to a value. The prototype can be either a plain object or an object type (as in the example below). An object type is in fact a plain object that also has a type definition (or [protocol](https://en.m.wikipedia.org/wiki/Protocol_(object-oriented_programming))).

```lua
#person: [
    name: #string
    age: #number
]

joe: #person [name: 'Joe', age: 27]
```

**kesh** inherits TypeScript's gradual and structural type system, with some differences. For example, **kesh** uses zero-values for its primitive types (all "falsy" values).

```lua
boolean:  #boolean  --> false
number:   #number   --> 0
string:   #string   --> ''
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
