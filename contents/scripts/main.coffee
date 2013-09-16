require './vendor/jade.js'

require './vendor/jquery.js'
require './vendor/bootstrap.js'

window._ = require './vendor/lodash.js'

window.Backbone = require './vendor/backbone.js'
window.Backbone.$ = jQuery

require './vendor/backbone.marionette.js'
require './vendor/marionette.appliances.js'


class Application extends Backbone.Marionette.ApplianceManager
  appliances: [
    'music'
  ]

  modules:
    music:
      controller: require('./music/controller.coffee')

  require: (appliance, type) ->
    if @modules?[appliance]?[type]?
      return @modules[appliance][type]

    return {}


application = new Application
application.start()
