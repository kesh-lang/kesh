import axios: 'axios'


axios.get('/users').then (res) -> print res.data


axios.get '/user?ID=12345'
    .then (response) ->
        print response
    .catch (error) ->
        print error


axios.post('/user', [
        first-name: 'Fred'
        last-name: 'Flintstone'
    ])
    .then (response) -> print response
    .catch (error) -> print error


get-user-account: () -> axios.get '/user/12345'
get-user-permissions: () -> axios.get '/user/12345/permissions'
Promise.all [get-user-account(), get-user-permissions()]
    .then (results) ->
        account: results.0
        permissions: results.1


axios([
    method: 'get'
    url: 'http://bit.ly/2mTM3nY'
    responseType: 'stream'
]).then (response) ->
    response.data.pipe fs.createWriteStream 'ada_lovelace.jpg'


instance: axios.create [
    baseURL: 'https://some-domain.com/api/'
    timeout: 1000
    headers: ['X-Custom-Header': 'foobar']
]
