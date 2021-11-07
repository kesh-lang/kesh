#kesh 2021 + async + globals

sleep: async (seconds) -> Promise (resolve) -> setTimeout(resolve, seconds * 1000)

print "Hold up"
await sleep 1
print "Hey!"
