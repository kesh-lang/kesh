# Examples

Variables and values are immutable by default (single assign, value semantics).

```lua
answer: 42
```

The `mutation` pragma enables the `let` and `set` keywords to mutate variables and fields, and the `*` operator to mark collections as mutable.

```lua
#!kesh 2021 (mutation)

let mutable: false  -- mutable variable
set mutable: true

joe: *[name: 'Joe']  -- mutable collection
set joe.name: 'Joseph'
```

Using `:` as the assignment operator means `=` is free to be used as the strict equality operator, as it should be. `/=` or `≠` represents strict inequality.

```lua
answer = 42    --> true (strict equality)
answer ≠ '42'  --> true (strict inequality, not the same type)
```

Similarly, `~=` or `≈` represents loose equality and `~/=` or `≉` loose inequality.

```lua
answer ≈ '42'  --> true (loose equality with type coercion)
answer ≉ '42'  --> false (loose inequality with type coercion)
```

Logical operators use words instead of signs.

```lua
not true        --> false
true and false  --> false
true or false   --> true
```

Conditionals are either `if…else…` expressions or ternary `…if…else…` expressions.

```lua
foo: if age < 13 { 'kid' } else if age < 18 { 'teenager' } else { 'adult' }
bar: 'kid' if age < 13 else 'teenager' if age < 18 else 'adult'
```

Tuples and array items may be accessed by index using dot notation.

```lua
(1, 2, 3).0         --> 1
(foo: 1, bar: 2).1  --> 2
[3, 14, 42].2       --> 42
```
