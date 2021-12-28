// https://github.com/kesh-lang/kesh/wiki/Extensions#imperative-loops

// infinite loop
while (true) {
  await client.listen()
}

// repeat a block x times
for (let i = 0; i < 3; ++i) {
  console.log("hey")
}

// loop over an iterable's elements
for (const number of $range(1, 10)) {
  if ($mod(number, 3) === 0) continue
  console.log(number)
}

// loop over a collection's own enumerable fields
for ([player, points] of score) {
  console.log(`${player.name}: ${points} points`)
}

// traditional while loop
while (everything === 'ok') {
  console.log("It's all good")
}

// untraditional until loop
while (!done) {
  // todo: process something
  if (nothingToDo) done = true
}

// traditional for loop
for (let i = 0; i < 9; ++i) {
  console.log(i)
}
