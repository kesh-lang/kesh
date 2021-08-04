# Bracketless

Where brackets are omitted, indentation becomes significant (the [offside rule](https://en.m.wikipedia.org/wiki/Off-side_rule)).

```lua
#!kesh 2021

-- indented lines get parsed as a collection by default
#person:
    name: #string
    age: #number
    speak: () -> #string

person:
    speak: () -> "Hi, I'm { this.name }."

joe: person
    name: 'Joe'
    age: 27

joe.speak()  --> 'Hi, I'm Joe.'

-- an arrow before indented lines opens a function's code block (return type may also be specified)
greet: ([name, age]: #person) -> #string
    someone: name if age > 12 else 'kid'
    "Hey, { someone }!"

-- a function's argument does not have to be a tuple
greet joe  --> 'Hey, Joe!'
greet      --> 'Hey, kid!'
    name: 'Johnny'
    age: 10
```