// https://github.com/kesh-lang/kesh/wiki/Extensions#defer

const count = () => {
  const $defer = []
  console.log('counting')

  for (const number of [1, 2, 3]) {
    $defer.unshift(() => console.log(number))
  }

  const $return = console.log('done')
  $defer.forEach(fn => fn())
  return $return
}

count()

// "counting"
// "done"
// 3
// 2
// 1
