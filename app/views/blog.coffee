class ArticleView extends Marionette.ItemView
  tagName: 'article'
  template: require 'templates/blog/index'

  parse: (data) ->
    console.dir data

    return data

class IndexView extends Marionette.CollectionView
  itemView: ArticleView
  tagName: 'section'

module.exports = {
  ArticleView
  IndexView
}
