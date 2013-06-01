{ArticleCollection} = require 'models/blog'
{IndexView} = require 'views/blog'

class BlogController extends Marionette.Controller
  index: ->
    articles = new ArticleCollection

    articles.once 'sync', =>
      index = new IndexView
        collection: articles

      @options.application.contentContainer.show index

    articles.fetch()

module.exports = {
  Controller: BlogController
}
