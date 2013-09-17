window.$ = window.jQuery = require './vendor/jquery.js'
window._ = require './vendor/lodash.js'
window.Backbone = require './vendor/backbone.js'
window.Backbone.$ = window.jQuery

require './vendor/backbone.marionette.js'
require './vendor/marionette.appliances.js'
require './vendor/bootstrap.js'


class Application extends Backbone.Marionette.ApplianceManager
  appliances: [
    'music'
  ]

  modules:
    music:
      controller: require './music/controller.coffee'

  require: (appliance, type) ->
    if @modules?[appliance]?[type]?
      return @modules[appliance][type]

    return {}


application = new Application
jQuery -> application.start()
