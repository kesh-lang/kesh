<!-- original: https://github.com/sveltejs/realworld/blob/master/src/lib/ArticleList/ArticlePreview.svelte -->

<script lang="coffee">
    import api: '$lib/api.js'
    
    let article
    let user
    
    favorite-path: "articles/{ article.slug }/favorite"
    
    toggle-favorite: async () *->
        if ~article.favorited
            set article.favorites-count: _ - 1
            set article.favorited: false
            set [article]: await api.del(favorite-path, user.token)
        else
            set article.favorites-count: _ + 1
            set article.favorited: true
            set [article]: await api.post(favorite-path, null, user.token)
    
    [article, user]
</script>

<div class="article-preview">
    <div class="article-meta">
        <a href="/profile/@{ article.author.username }">
            <img src={ article.author.image } alt={ article.author.username } />
        </a>

        <div class="info">
            <a class="author" href="/profile/@{ article.author.username }"> { article.author.username } </a>
            <span class="date"> { Date(article.createdAt).toDateString() } </span>
        </div>

        { #if user }
            <div class="pull-xs-right">
                <button
                    class="btn btn-sm { 'btn-primary' if article.favorited else 'btn-outline-primary' }"
                    on:click={ toggle-favorite }
                >
                    <i class="ion-heart" />
                    { article.favorites-count }
                </button>
            </div>
        { /if }
    </div>

    <a href="/article/{ article.slug }" rel="prefetch" class="preview-link">
        <h1>{ article.title }</h1>
        <p>{ article.description }</p>
        <span>Read more...</span>
        <ul class="tag-list">
            { #each article.tagList as tag }
                <li class="tag-default tag-pill tag-outline"><a href="/?tag={ tag }">{ tag }</a></li>
            { /each }
        </ul>
    </a>
</div>


