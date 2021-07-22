# Minimal syntax

By omitting brackets, indentation becomes significant (the [offside rule](https://en.m.wikipedia.org/wiki/Off-side_rule)).

Indented lines assigned to a variable are parsed as a collection by default. A leading arrow (`->`) creates a function body.

```lua
#person:                                        -- type definition
    name: #string                               -- type annotation
    age: #number

greet([name, age]: #person) #string: ->         -- typed function declaration assigned a code block
    name: name if age > 12 else 'kid'           -- variable declaration using an if-else expression
    "Hey, { name }!"                            -- implicit return of the block's last expression

joe:                                            -- variable declaration assigned a record
    name: 'Joe'
    age: 27

print greet joe                                 --> 'Hey, Joe!'
```
