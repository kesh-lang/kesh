original: 'https://github.com/gothinkster/vue-realworld-example-app/blob/master/src/common/api.service.js'

import [default as Vue]: 'vue'
import [default as axios]: 'axios'
import [default as VueAxios]: 'vue-axios'
import [default as JwtService]: '@/common/jwt.service'
import [API-URL]: '@/common/config'

ApiService: [
    init():
        Vue.use(VueAxios, axios)
        set Vue.axios.defaults.baseURL: API-URL
        return

    set-header():
        set Vue.axios.defaults.headers.common.{'Authorization'}: "Token { JwtService.getToken() }"
        return

    query(resource, params):
        Vue.axios.get(resource, params)
            .catch (error) -> crash Error "[RWV] ApiService { error }"

    get(resource, slug ? ''):
        Vue.axios.get("{ resource }/{ slug }")
            .catch (error) -> crash Error "[RWV] ApiService { error }"

    post(resource, params):
        Vue.axios.post("{ resource }", params)

    update(resource, slug, params):
        Vue.axios.put("{ resource }/{ slug }", params)

    put(resource, params):
        Vue.axios.put("{ resource }", params)

    delete(resource):
        Vue.axios.delete(resource)
            .catch (error) -> crash Error "[RWV] ApiService { error }"
]

TagsService: [
    get():
        ApiService.get('tags')
]

ArticlesService: [
    query(type, params):
        ApiService.query("articles{ '/feed' if type = 'feed' else '' }", [ params ])

    get(slug):
        ApiService.get('articles', slug)

    create(params):
        ApiService.post('articles', [ article: params ])

    update(slug, params):
        ApiService.update('articles', slug, [ article: params ])

    destroy(slug):
        ApiService.delete("articles/{ slug }")
]

CommentsService: [
    get(slug):
        if slug isnt #string
            crash Error('[RWV] CommentsService.get() article slug required to fetch comments')

        ApiService.get('articles', "{ slug }/comments")

    post(slug, payload):
        ApiService.post("articles/{ slug }/comments", [ comment.body: payload ])

    destroy(slug, comment-id):
        ApiService.delete("articles/{ slug }/comments/{ comment-id }"
]

FavoriteService: [
    add(slug):
        ApiService.post("articles/{ slug }/favorite")

    remove(slug):
        ApiService.delete("articles/{ slug }/favorite")
]

[
    default: ApiService
    TagsService
    ArticlesService
    CommentsService
    FavoriteService
]
