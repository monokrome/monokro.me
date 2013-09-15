require './vendor/jquery.js'
require './vendor/bootstrap.js'

window._ = require './vendor/lodash.js'

window.Backbone = require './vendor/backbone.js'
window.Backbone.$ = jQuery

require './vendor/backbone.marionette.js'
require './vendor/marionette.appliances.js'


class Application extends Backbone.Marionette.ApplianceManager
  appliances: []
  modules: {}

  require: (appliance, type) ->
    if @modules?[appliance]?[type]?
      return @modules[appliance][type]

    return {}


application = new Application
application.start()
