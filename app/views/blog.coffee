class ArticleView extends Marionette.ItemView
  tagName: 'article'
  template: require 'templates/blog/index'

class IndexView extends Marionette.CollectionView
  itemView: ArticleView
  tagName: 'section'

module.exports = {
  ArticleView
  IndexView
}
