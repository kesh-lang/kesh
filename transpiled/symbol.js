// https://github.com/kesh-lang/kesh/wiki/Documentation#hidden-fields
// https://github.com/kesh-lang/kesh/wiki/Documentation#computed-keys
// https://github.com/kesh-lang/kesh/wiki/Documentation#field-access

// secret: @('hidden talent')
const secret = Symbol('hidden talent')  // secret symbol

// person: object[ name: 'Joe', @cool: true, { secret }: 'I can moonwalk!' ]
const person = Object.freeze({
  name: 'Joe',
  [Symbol.for('cool')]: true,
  [secret]: "I can moonwalk!",
})

// keys person
keys(person)
// Array [ "name" ]

// person.@cool
person[Symbol.for('cool')]
// true

// person.{ secret }
person[secret]
// "I can moonwalk!"


keys = (collection) => {
  const keys = []
  for (const key in collection) {
    keys.push(key)
  }
  return keys
}
