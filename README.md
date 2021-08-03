# kesh { }

A simple little programming language on top of TypeScript

<p>&nbsp;</p>
<p align="center" width="100%"><img width="33%" alt="heyiya-if symbol" src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Double_spirale.svg"></p>
<p>&nbsp;</p>

> A long, long time from now, in the wake of what will no longer be called JavaScript, might be going to have existed a programming language called _kesh_.


```lua
#!kesh 2021 (strict)

-- type
#person: [                                  -- type definition
    name: #string                           -- type annotation
    age: #number
    speak: () -> #string                    -- type signature
]

-- prototype
person: [                                   -- variable initialized with an object
    speak: () -> "Hi, I'm { this.name }."   -- field assigned a simple inline function
]

-- instance
joe: person [                               -- new object created from prototype
    name: 'Joe'
    age: 27
]

greet: ([name, age]: #person) -> {          -- typed function with argument unpacking
    someone: name if age > 12 else 'kid'
    "Hey, { someone }!"                     -- the block's last expression is returned
}                                           -- and its return type inferred

joe.speak()                                 --> 'Hi, I'm Joe.'
greet joe                                   --> 'Hey, Joe!'
```

The syntax is a strict superset of [na](https://github.com/kesh-lang/na). A [minimal syntax](./minimal-syntax.md) is also supported.

Contributions are always welcome.


<sub>[heyiya-if symbol](https://commons.wikimedia.org/wiki/File:Double_spirale.svg) is [CC0](https://creativecommons.org/publicdomain/zero/1.0/). Original by [Margaret Chodos-Irvine](https://chodos-irvine.com/) for [Ursula Le Guin](https://www.ursulakleguin.com/)'s novel about the Kesh, [Always Coming Home](https://www.ursulakleguin.com/always-coming-home-book).</sub>
