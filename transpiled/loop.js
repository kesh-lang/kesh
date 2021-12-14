// https://github.com/kesh-lang/kesh/wiki/Extensions#imperative-loops

// infinite loop
while (true) {
  await client.listen()
}

// repeat a block x times using a range (iterable)
for (const $ of [1, 2, 3]) {
  console.log("hey")
}

// loop over an iterable's elements
for (const number of $range(1, 10)) {
  if ($mod(number, 3) === 0) continue
  console.log(number)
}

// loop over a collection's own enumerable fields
for ([key, value] of Object.entries(person)) {
  console.log(key, value)
}

// traditional while loop
while (everything === 'ok') {
  console.log("It's all good")
}

// nontraditional until loop
while (!done) {
  // todo: process something
  if (nothingToDo) done = true
}

// traditional for loop
for (let i = 0; i < 9; ++i) {
  console.log(i)
}
