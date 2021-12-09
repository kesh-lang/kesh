sleep: async (seconds) ->
    Promise (resolve) -> set-timeout(resolve, seconds * 1000ms)

print 'Hold up'
await sleep 1s
print 'Hey!'
