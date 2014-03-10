discoverArticles = (configuration) -> (contents) ->
  articles = contents.blog[configuration.articles]._.directories.map (item) -> item.index
  articles.sort (a, b) -> b.date - a.date
  return articles


merge = (dest, sources...) ->
  for source in sources
    for key, value of source
      if source[key]? and typeof value is 'object'
        value = merge {}, dest[key], source[key]

      dest[key] = value

  return dest


defaults =
  template: 'blog.jade'
  articles: 'articles'
  articlesPerPage: 3

  pages:
    initial: 'index.html'
    consecutive: '%d.html'


module.exports = (env, callback) ->
  class BlogPage extends env.plugins.Page
    previous: null
    next: null

    constructor: (@configuration, @number, @articles) ->

    getFilename: ->
      return @configuration.pages.initial?.replace '%d', @number
      return @configuration.pages.consecutive.replace '%d', @number

    getView: -> (env, locals, contents, templates, callback) ->
      template = templates[@configuration.template]

      unless template?
        throw new Error "Template #{ configuration.template } does not exist."

      context =
        articles: @articles
        pages:
          previous: @previous
          next: @next

      env.utils.extend context, locals
      template.render context, callback

  configuration = env.config.blog or {}
  configuration = merge {}, defaults, configuration

  discover = discoverArticles configuration

  env.registerGenerator 'blog', (contents, callback) ->
    articles = discover contents
    pageCount = Math.ceil articles.length / configuration.articlesPerPage

    lastPage = null
    tree =
      blog:
        pages: {}

    for index in [0..pageCount]
      pageNumber = index + 1

      first = index * configuration.articlesPerPage
      last = pageNumber * configuration.articlesPerPage

      break if first >= articles.length

      page = new BlogPage configuration, pageNumber, articles.slice first, last

      if lastPage?
        page.previous = lastPage
        lastPage.next = page
      else
        tree.blog['index.page'] = page

      tree.blog.pages[page.number + '.page'] = page
      lastPage = page

    callback null, tree

  env.helpers.blog =
    discoverArticles: discover

  callback()
