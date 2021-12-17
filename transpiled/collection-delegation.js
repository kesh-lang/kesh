// https://github.com/kesh-lang/kesh/wiki/Documentation#delegation

const primate = Object.freeze({
  tail: true,
})

const human = Object.freeze(Object.create(primate, {  // delegation
  tail: { value: false },  // overridden value
  walks: { value: true },
  talks: { value: true },
}))

const joe = Object.freeze(Object.create(human, {  // delegation
  name: { value: 'Joe' },
}))

// these objects are immutable:
joe.name = 'Joey'
joe.age = 27
joe
// Object { name: "Joe", tail: false, walks: true, talks: true }
