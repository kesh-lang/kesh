sleep: async (seconds) -> Promise (resolve) -> set-timeout(resolve, seconds * 1000)

print "Hold up"
await sleep 1
print "Hey!"
