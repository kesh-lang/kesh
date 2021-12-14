const primate = {
  tail: true,
}

const human = Object.create(primate, {  // delegation
  tail: { value: false },  // overridden value
  walks: { value: true },
  talks: { value: true },
})

const joe = Object.create(human, {  // delegation
  name: { value: 'Joe' },
})

// these objects are immutable:
joe.name = 'Joey'
joe.name
// 'Joe'
