// https://github.com/kesh-lang/kesh/wiki/Documentation#hidden-fields
// https://github.com/kesh-lang/kesh/wiki/Documentation#computed-keys
// https://github.com/kesh-lang/kesh/wiki/Documentation#field-access

// secret: @('hidden talent')
const secret = Symbol('hidden talent')  // secret symbol

// person: [ name: 'Joe', @cool: true, { secret }: 'I can moonwalk!' ]
const person = {
  name: 'Joe',
  [Symbol.for('cool')]: true,
  [secret]: "I can moonwalk!",
}

// keys person
Object.getOwnPropertyNames(person)
// Array [ "name" ]

// person.@cool
person[Symbol.for('cool')]
// true

// person.{ secret }
person[secret]
// "I can moonwalk!"
