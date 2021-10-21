# kesh { }

<p>&nbsp;</p>
<p align="center" width="100%"><img height="381px" alt="heyiya-if symbol" src="https://upload.wikimedia.org/wikipedia/commons/c/c2/Double_spirale.svg"></p>
<p>&nbsp;</p>

> A long, long time from now, in the wake of what will no longer be called JavaScript, might be going to have existed a programming language called _kesh_.

**kesh** is a simple little programming language. Its syntax is a superset of [na](https://github.com/kesh-lang/na).

```lua
#kesh 2021

-- prototype
#person: [                                           -- type definition
    name: #string                                    -- type annotation
    age: #number
    speak(): "Hi, I'm { this.name }."                -- literal method with type inference
]

-- instance
joe: #person [                                       -- new collection that delegates to #person
    name: 'Joe'
    age: 27
]

-- function
greet: (person: #person) ->                          -- typed function definition with a block body
    name: person.name if person.age > 12 else 'kid'  -- block scoped identifier definition
    "Hey, { name }!"                                 -- the last expression's value is returned

joe.speak()                                          --> 'Hi, I'm Joe.'
greet joe                                            --> 'Hey, Joe!'
```

Nothing is written in stone. Contributions are always welcome!

- [Documentation](https://github.com/kesh-lang/kesh/wiki/Documentation)
- [Extensions](https://github.com/kesh-lang/kesh/wiki/Extensions)
- [Language primitives](https://github.com/kesh-lang/kesh/wiki/Language-primitives)

<sub>[heyiya-if symbol](https://commons.wikimedia.org/wiki/File:Double_spirale.svg) is [CC0](https://creativecommons.org/publicdomain/zero/1.0/). Original by [Margaret Chodos-Irvine](https://chodos-irvine.com/) for [Ursula Le Guin](https://www.ursulakleguin.com/)'s novel about the Kesh, [Always Coming Home](https://www.ursulakleguin.com/always-coming-home-book).</sub>
