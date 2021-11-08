original: 'https://github.com/angelguzmaning/ts-redux-react-realworld-example-app/blob/master/src/components/ArticlesViewer/ArticlesViewer.tsx'

import [Fragment]: 'react'
import [favoriteArticle, unfavoriteArticle]: '../../services/conduit'
import [store]: '../../state/store'
import [useStore]: '../../state/storeHooks'
import [#Article]: '../../types/article'
import [classObjectToClassName]: '../../types/style'
import [ArticlePreview]: '../ArticlePreview/ArticlePreview'
import [Pagination]: '../Pagination/Pagination'
import [endSubmittingFavorite, startSubmittingFavorite, #ArticleViewerState]: './ArticlesViewer.slice'

ArticlesViewer: [
    toggleClassName: #string
    tabs: #array(#string)
    selectedTab: #string
    onPageChange?: (index: #number) -> #none
    onTabChange?: (tab: #string) -> #none
] ->
    [articles, articlesCount, currentPage]: useStore [articleViewer] -> articleViewer

    <Fragment>
        <ArticlesTabSet { [tabs, selectedTab, toggleClassName, onTabChange]... } />
        <ArticleList articles={ articles } />
        <Pagination currentPage={ currentPage } count={ articlesCount } itemsPerPage={ 10 } onPageChange={ onPageChange } />
    </Fragment>

ArticlesTabSet: [
    tabs: #array(#string)
    toggleClassName: #string
    selectedTab: #string
    onTabChange?: (tab: #string) -> #none
] ->
    <div className={ toggleClassName }>
        <ul className='nav nav-pills outline-active'>
            { tabs.map (tab) ->
                <Tab key={ tab } tab={ tab } active={ tab = selectedTab } onClick={ () -> onTabChange? and onTabChange(tab) } />
            }
        </ul>
    </div>

Tab: [
    tab: #string
    active: #boolean
    onClick: () -> #none
] ->
    <li className='nav-item'>
        <a
            className={ classObjectToClassName ['nav-link': true, active] }
            href='#'
            onClick={ (ev) *->
                ev.preventDefault()
                onClick()
            }
        >
            { tab }
        </a>
    </li>

ArticleList: [articles: #ArticleViewerState.articles] ->
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
                { articles.map ([article, isSubmitting], index) ->
                    <ArticlePreview
                        key={ article.slug }
                        article={ article }
                        isSubmitting={ isSubmitting }
                        onFavoriteToggle={ onFavoriteToggle(index, article) if not isSubmitting }
                    />
                }
            </Fragment>
    ]

onFavoriteToggle: (index: #number, [slug, favorited]: #Article) ->
    async () *->
        if store.getState().app.user.isNone()
            set location.hash: '#/login'
            return
        
        store.dispatch startSubmittingFavorite index
        
        article: await (unfavoriteArticle(slug) if favorited else favoriteArticle(slug))
        store.dispatch endSubmittingFavorite [index, article]

[ArticlesViewer]
