import axios: 'axios'


-- Minimal example
axios.get '/users'
    .then (res) -> print res.data


-- Make a request for a user with a given ID
axios.get '/user?ID=12345'
    .then (response) ->
        -- handle success
        print response
    .catch (error) ->
        -- handle error
        print error
    .then () ->
        -- always executed


-- Performing a POST request
axios.post('/user', [
        first-name: 'Fred'
        last-name: 'Flintstone'
    ])
    .then (response) -> print response
    .catch (error) -> print error


-- Performing multiple concurrent requests
requests: array[
    () -> axios.get '/user/12345'
    () -> axios.get '/user/12345/permissions'
]

Promise.all requests
    .then (results) ->
        account: results.0
        permissions: results.1


-- GET request for remote image in node.js
axios([
    method: 'get'
    url: 'http://bit.ly/2mTM3nY'
    response-type: 'stream'
]).then (response) ->
    response.data.pipe fs.create-write-stream 'ada_lovelace.jpg'


-- You can create a new instance of axios with a custom config
instance: axios.create [
    baseURL: 'https://some-domain.com/api/'
    timeout: 1000
    headers:
        'X-Custom-Header': 'foobar'
]
