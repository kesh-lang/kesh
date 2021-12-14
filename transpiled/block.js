// https://github.com/kesh-lang/kesh/wiki/Documentation#blocks

const a = 1
const answer = (() => {
  const a = 20
  const b = 22
  return a + b
})()

answer // 42
a      // 1
b      // ReferenceError: b is not defined
