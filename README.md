# kesh { }

<p>&nbsp;</p>
<p align="center" width="100%"><img width="33%" alt="heyiya-if symbol" src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Double_spirale.svg"></p>
<p>&nbsp;</p>

> A long, long time from now, in the wake of what will no longer be called JavaScript, might be going to have existed a programming language called _kesh_.


```lua
#person: [                         -- type definition
    name: #string                  -- type annotation
    age: #number
]

greet(person: #person) #string: {  -- typed function declaration assigned a block of code
    name: person.name              -- variable declaration (immutable)
    "Hey, { name }!"               -- implicit return of the block's last expression
}

joe: [                             -- variable declaration assigned a record
    name: 'Joe'
    age: 27
]

print greet(person: joe)           --> 'Hey, Joe!'
```

The syntax is a strict superset of [na](https://github.com/kesh-lang/na).

---

<sup>[heyiya-if symbol](https://commons.wikimedia.org/wiki/File:Double_spirale.svg) is [CC0](https://creativecommons.org/publicdomain/zero/1.0/)</sup>
