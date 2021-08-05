# Examples

Variables and values are immutable by default (single assignment, value semantics).

```lua
answer: 42
```

The `mutation` directive enables the `let` and `set` keywords to mutate variables and fields, and the `*` operator to mark collections as mutable.

```lua
#!kesh 2021 (mutation)

let mutable: false  -- mutable variable
set mutable: true

joe: *[name: 'Joe']  -- mutable collection
set joe.name: 'Joseph'
```

Using `:` as the assignment operator means `=` is free to be used as the equality operator, as it should be. `=` represents strict equality, where both operands must be of the same type. `/=` (`≠`) represents strict inequality.

```lua
answer = 42    --> true (strict equality)
answer ≠ '42'  --> true (strict inequality)
```

Similarly, `~=` represents loose equality and `~/=` (`~≠`) loose inequality, with type coercion of operands.

```lua
answer ~= '42'  --> true (loose equality)
answer ~≠ '42'  --> false (loose inequality)
```

Logical operators use words instead of signs.

```lua
not true        --> false
true and false  --> false
true or false   --> true
```

Everything is an expression. Conditionals are either the old `if…else…` construct, the ternary `…if…else…` or pattern-matching `match`.

```lua
old: if age < 13 {
    'kid'
}
else if age < 20 {
    'teenager'
}
else {
    'adult'
}

ternary: 'kid' if age < 13 else 'teenager' if age < 20 else 'adult'
default: 'kid' if age < 13  --> () if the condition is false

pattern: match age
    | 0..12   -> 'kid'       -- range is inclusive
    | 13..<20 -> 'teenager'  -- range is exclusive
    | 20..    -> 'adult'     -- to infinity (and beyond!)
```

Since blocks return the value of the last line, they can be used to produce a value within a local scope.

```lua
answer: {
    a: 3
    b: 14
    a * b
}  --> 42
```
