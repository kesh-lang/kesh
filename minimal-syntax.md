# Minimal syntax

By omitting brackets, indentation becomes significant (the [offside rule](https://en.m.wikipedia.org/wiki/Off-side_rule)).

Indented lines assigned to a variable are parsed as a collection by default.

```lua
#person:                                        -- type definition
    name: #string                               -- type annotation
    age: #number
```

A leading arrow assigns a function body.

```lua
greet([name, age]: #person) #string: ->         -- typed function declaration assigned a code block
    name: name if age > 12 else 'kid'           -- variable declaration using an if-else expression
    "Hey, { name }!"                            -- implicit return of the block's last expression

joe:                                            -- variable declaration assigned a record
    name: 'Joe'
    age: 27
```

Functions called with only one argument don't require parens.

```lua
print greet joe                                 --> 'Hey, Joe!'
```
