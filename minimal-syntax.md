# Minimal syntax

By omitting brackets, indentation becomes significant (the [offside rule](https://en.m.wikipedia.org/wiki/Off-side_rule)).

Indented lines assigned to a variable are parsed as a collection by default.

```lua
#person:
    name: #string
    age: #number

joe:
    name: 'Joe'
    age: 27
```

A leading arrow assigns a function body.

```lua
greet([name, age]: #person) #string: ->
    name: name if age > 12 else 'kid'
    "Hey, { name }!"
```

Functions called with only one argument don't require parens.

```lua
print greet joe  --> 'Hey, Joe!'

print greet [name: 'Johnny', age: 10]  --> 'Hey, kid!'
```
