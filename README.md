# kesh { }

A simple little language on top of TypeScript

<p>&nbsp;</p>
<p align="center" width="100%"><img width="33%" alt="heyiya-if symbol" src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Double_spirale.svg"></p>
<p>&nbsp;</p>

> A long, long time from now, in the wake of what will no longer be called JavaScript, might be going to have existed a programming language called _kesh_.


```lua
-- type
#person: [                                      -- type definition
    name: #string                               -- type annotation
    age: #number
]

-- prototype
person: [                                       -- variable assigned a collection
    speak: -> "Hi, my name is { this.name }."   -- field assigned a simple inline function
]

-- instance
joe: person [                                    -- new collection created from prototype
    name: 'Joe'
    age: 27
]

greet: ([name, age]: #person) -> {              -- typed function with argument unpacking
    name: name if age > 12 else 'kid'           -- variable shadowing using an if-else expression
    "Hey, { name }!"                            -- the block's last expression is returned
}

joe.speak()                                     --> 'Hi, my name is Joe.'
greet joe                                       --> 'Hey, Joe!'
```

The syntax is a strict superset of [na](https://github.com/kesh-lang/na). A [minimal syntax](./minimal-syntax.md) is also supported.


<sub>[heyiya-if symbol](https://commons.wikimedia.org/wiki/File:Double_spirale.svg) is [CC0](https://creativecommons.org/publicdomain/zero/1.0/)</sub>
