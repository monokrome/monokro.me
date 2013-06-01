class ArticleModel extends Backbone.Model
  url: '/api/blog/articles.json'

  parse: (response) ->
    getContent = require "articles/#{response.filename}"

    content = getContent()

    date = response.date

    if content[0..3] == '<h1>'
      contentParts = content[4..].split '</h1>'

      header = contentParts[0]
      body = jQuery.trim contentParts[1..].join('</h1>')

    else
      header = null
      body = jQuery.trim content

    return {date, header, body}

class ArticleCollection extends Backbone.Collection
  url: '/api/blog/articles.json'
  model: ArticleModel

module.exports = {ArticleCollection}
