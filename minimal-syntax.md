# Minimal syntax

By omitting brackets, indentation becomes significant (the [offside rule](https://en.m.wikipedia.org/wiki/Off-side_rule)).

```lua
-- indented lines assigned to a type/variable gets parsed as a collection
#person:
    name: #string
    age: #number

joe:
    name: 'Joe'
    age: 27

-- an arrow before indented lines opens a function's code block
greet: ([name, age]: #person) ->
    name: name if age > 12 else 'kid'
    "Hey, { name }!"

-- a function's argument does not have to be a tuple
greet joe  --> 'Hey, Joe!'
greet [name: 'Johnny', age: 10]  --> 'Hey, kid!'
```
