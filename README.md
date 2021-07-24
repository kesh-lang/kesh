# kesh { }

<p>&nbsp;</p>
<p align="center" width="100%"><img width="33%" alt="heyiya-if symbol" src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Double_spirale.svg"></p>
<p>&nbsp;</p>

> A long, long time from now, in the wake of what will no longer be called JavaScript, might be going to have existed a programming language called _kesh_.


```lua
#person: [                                      -- type definition
    name: #string                               -- type annotation
    age: #number
]

joe: [                                          -- variable declaration assigned a record
    name: 'Joe'
    age: 27
]

greet([name, age]: #person) #string: {          -- typed function declaration assigned a code block
    name: name if age > 12 else 'kid'           -- variable shadowing using an if-else expression
    "Hey, { name }!"                            -- implicit return of the block's last expression
}

print greet(joe)                                --> 'Hey, Joe!'
```

The syntax is a strict superset of [na](https://github.com/kesh-lang/na). A [minimal syntax](./minimal-syntax.md) is also supported.

---

<sup>[heyiya-if symbol](https://commons.wikimedia.org/wiki/File:Double_spirale.svg) is [CC0](https://creativecommons.org/publicdomain/zero/1.0/)</sup>
