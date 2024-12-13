# kesh { }

<p>&nbsp;</p>
<p align="center" width="100%"><img height="381px" alt="heyiya-if symbol" src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Double_spirale.svg"></p>
<p>&nbsp;</p>

> A long, long time from now, in the wake of what will no longer be called JavaScript,  
> might be going to have existed a programming language called _kesh_.

**kesh** is a simple high-level programming language that hasn't been made. Its syntax is a superset of [na](https://github.com/kesh-lang/na).

```lua
kesh 2021

-- prototype
#person: [                                        -- type definition
    name: #text                                   -- type annotation
    age: #number
    speak(): "Hi, I'm { this.name }."             -- literal method (type inference)
]

-- instance
joe: #person [                                    -- new collection that delegates to #person
    name: 'Joe'
    age: 27
]

-- function
greet: ([name, age]: #person) -> {                -- typed function (argument unpacking)
    name: name if age > 12 else 'kid'             -- block-scoped declaration (param masking)
    "Hey, { name }!"                              -- the last evaluated expression is returned
}

joe.speak()                                       --> "Hi, I'm Joe."

greet joe                                         --> "Hey, Joe!"
```

See the [Documentation](https://github.com/kesh-lang/kesh/wiki/Documentation) for more.

Nothing is written in stone. Feedback and contributions are always welcome!

<sub>[heyiya-if symbol](https://commons.wikimedia.org/wiki/File:Double_spirale.svg) is [CC0](https://creativecommons.org/publicdomain/zero/1.0/). Original by [Margaret Chodos-Irvine](https://chodos-irvine.com/) for [Ursula Le Guin](https://www.ursulakleguin.com/)'s novel about [the Kesh](https://www.ursulakleguin.com/kesh-music), [Always Coming Home](https://www.ursulakleguin.com/always-coming-home-book).</sub>
