# Minimal syntax

By omitting brackets, indentation becomes significant (the [offside rule](https://en.m.wikipedia.org/wiki/Off-side_rule)).

```lua
-- indented lines assigned to a variable/type gets parsed as a collection
#person:
    name: #string
    age: #number

joe:
    name: 'Joe'
    age: 27

-- an arrow before indented lines opens a code block
greet: ([name, age]: #person) ->
    name: name if age > 12 else 'kid'
    "Hey, { name }!"

-- functions called with only one argument don't require parens
greet joe  --> 'Hey, Joe!'
greet [name: 'Johnny', age: 10]  --> 'Hey, kid!'
```
