const open = async function*(path) {
  const file = await fs.open(path)
  console.log("file opened")

  yield file

  file.close()
  return console.log("file closed")
}

for await (const file of open("./hello.txt")) {
  console.log(file.contents)
}
