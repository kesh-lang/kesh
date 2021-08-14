# Bracketless

Where brackets are omitted, indentation becomes significant (the [offside rule](https://en.m.wikipedia.org/wiki/Off-side_rule)).

```lua
#!kesh 2021

-- indented lines get parsed as a collection by default
#person:
    name: #string
    age: #number
    speak: () -> "Hi, I'm { this.name }."

-- the following can be read as "joe is a person with name 'Joe' and age 27"
joe: #person
    name: 'Joe'
    age: 27

joe.speak()
--> 'Hi, I'm Joe.'

-- an arrow before indented lines opens a code block (the function's return type may also be specified)
greet: ([name, age]: #person) -> #string
    someone: name if age > 12 else 'kid'
    "Hey, { someone }!"

-- if a function is applied to a single value, the value doesn't need to be wrapped in a tuple
greet joe
--> 'Hey, Joe!'

-- a function applied to an object literal linked to a prototype would look like this
greet #person
    name: 'Johnny'
    age: 10
--> 'Hey, kid!'
```
