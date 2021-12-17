// https://github.com/kesh-lang/kesh/wiki/Documentation#composition

const newPerson = (spec) => {
  const { name = 'Anonymous' } = spec  // unpacked field from spec
  const aHuman = human(spec)           // private field (composition)
  
  const say = (words) => {
    aHuman.speak(`${ name } says: ${ words }`)  // no this
  }
  
  return Object.freeze({ name, say })  // public fields returned from function
}

const joe = newPerson(Object.freeze({
  name: 'Joe',
}))

joe
// Object { name: "Joe", say: say(words) }

joe.say("Hi!")
// "Joe says: Hi!"
