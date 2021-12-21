// https://github.com/kesh-lang/kesh/wiki/Documentation#operators

// answer = 42
answer === 42

// answer /= '42'
answer !== '42'

// answer ~= '42'
answer == '42'

// answer ~≠ '42'
answer != '42'

// not true
!true

// true and false
true && false

// true or false
true || false

// truthy: []
// if ~truthy then print 'It is truthy'
const truthy = {}
if (truthy) console.log('It is truthy')

// if page.title? and page.author?
if (page.title !== undefined && page.author !== undefined) {}

// title: page.title ? 'Default title'
const title = page.title ?? 'Default title'

// spread: [items..., item]
const spread = { ...items, item }

// rest: (...arguments) -> print arguments
const rest = (...arguments) => console.log(arguments)

// [age as years-old]: ada
const { age: yearsOld } = ada

// 4 + #number '2'
4 + Number('2')

// joe inherits primate
primate.isPrototypeOf(joe)
inherits(primate, joe)  // function version

// joe is-a human
Reflect.getPrototypeOf(joe) === human
isA(human, joe)  // function version

// answer is #number
typeof answer === 'number'
is('number', answer)  // function version

// answer isnt #text
typeof answer !== 'string'
isnt('string', answer)  // function version

// people has joe
has(joe, people)  // only as a function


// rudimentary implementation of has function
function has(val, col) {
  if (Array.isArray(col)) {
    return col.includes(val)
  }
  else if (col instanceof Set || col instanceof Map) {
    return col.has(val)
  }
  else {
    return Reflect.has(col, val)
  }
}
