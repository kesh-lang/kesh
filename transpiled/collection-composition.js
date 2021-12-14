// https://github.com/kesh-lang/kesh/wiki/Documentation#composition

const newPerson = (spec) => {
  const {name = 'Anonymous'} = spec  // unpacked field from spec
  const aHuman = human(spec)         // private field (composition)
  
  const say = (words) => {
    aHuman.speak(`${ name } says: ${ words }`)  // no this
  }
  
  return {name, say}  // public fields returned from function
}

const joe = newPerson({
  name: 'Joe',
})

joe
// Object { name: "Joe", say: say(words) }

joe.say("Hi!")
// "Joe says: Hi!"
