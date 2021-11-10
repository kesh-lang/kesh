original: 'https://github.com/angelguzmaning/ts-redux-react-realworld-example-app/blob/master/src/components/ArticlesViewer/ArticlesViewer.tsx'

import [Fragment]: 'react'
import [favorite-article, unfavorite-article]: '../../services/conduit'
import [store]: '../../state/store'
import [use-store]: '../../state/storeHooks'
import [#Article]: '../../types/article'
import [class-object-to-class-name]: '../../types/style'
import [ArticlePreview]: '../ArticlePreview/ArticlePreview'
import [Pagination]: '../Pagination/Pagination'
import [end-submitting-favorite, start-submitting-favorite, #ArticleViewerState]: './ArticlesViewer.slice'

ArticlesViewer: [
    toggle-class-name: #string
    tabs: #array(#string)
    selected-tab: #string
    on-page-change?: (index: #number) -> #none
    on-tab-change?: (tab: #string) -> #none
] ->
    [articles, articles-count, current-page]: use-store [article-viewer] -> article-viewer

    <Fragment>
        <ArticlesTabSet { [tabs, selected-tab, toggle-class-name, on-tab-change]... } />
        <ArticleList articles={ articles } />
        <Pagination currentPage={ current-page } count={ articles-count } itemsPerPage={ 10 } onPageChange={ on-page-change } />
    </Fragment>

ArticlesTabSet: [
    tabs: #array(#string)
    toggle-class-name: #string
    selected-tab: #string
    on-tab-change?: (tab: #string) -> #none
] ->
    <div className={ toggle-class-name }>
        <ul className='nav nav-pills outline-active'>
            { tabs.map (tab) ->
                <Tab key={ tab } tab={ tab } active={ tab = selected-tab } onClick={ () -> if on-tab-change? then on-tab-change tab } />
            }
        </ul>
    </div>

Tab: [
    tab: #string
    active: #boolean
    on-click: () -> #none
] ->
    <li className='nav-item'>
        <a
            className={ class-object-to-class-name ['nav-link': true, active] }
            href='#'
            onClick={ (ev) *=>
                ev.prevent-default()
                on-click()
            }
        >
            { tab }
        </a>
    </li>

ArticleList: [
    articles: #ArticleViewerState.articles
] ->
    articles.match [
        none: () ->
            <div className='article-preview' key={ 1 }>
                Loading articles...
            </div>
        some: (articles) ->
            <Fragment>
                { if articles.length = 0
                    <div className='article-preview' key={ 1 }>
                        No articles are here... yet.
                    </div>
                }
                { articles.map ([article, is-submitting], index) ->
                    <ArticlePreview
                        key={ article.slug }
                        article={ article }
                        isSubmitting={ is-submitting }
                        onFavoriteToggle={ on-favorite-toggle(index, article) if not is-submitting }
                    />
                }
            </Fragment>
    ]

on-favorite-toggle: (index: #number, [slug, favorited]: #Article) ->
    async () *->
        if store.get-state().app.user.is-none()
            set location.hash: '#/login'
        else
            store.dispatch start-submitting-favorite index
            article: await unfavorite-article(slug) if favorited else favorite-article(slug)
            store.dispatch end-submitting-favorite [index, article]

[ArticlesViewer]
