{BlogController} = require 'controllers/blog'

class BlogRouter extends Marionette.AppRouter
  appRoutes:
    '': 'index'
    'blog': 'index'

module.exports = {
  Router: BlogRouter
}
