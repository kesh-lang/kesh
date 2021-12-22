import axios: 'axios'


-- Minimal example
axios.get '/users'
    .then (response) -> response.data
    .then print


-- Make a request for a user with a given ID
axios.get "/user?ID={ id }"
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
    .then print
    .catch print


-- Performing multiple concurrent requests
requests: [
    () -> axios.get "/user/{ id }"
    () -> axios.get "/user/{ id }/permissions"
]

Promise.all requests
    .then array[account, permissions] ->  -- unpacking the result array
        print account
        print permissions


-- GET request for remote image in node.js
axios([
    method: 'get'
    url: 'http://bit.ly/2mTM3nY'
    response-type: 'stream'
]).then [data] ->
    data.pipe fs.create-write-stream 'ada_lovelace.jpg'


-- You can create a new instance of axios with a custom config
instance: axios.create [
    base-URL: 'https://some-domain.com/api/'
    timeout: 1000
    headers:
        'X-Custom-Header': 'foobar'
]
