class Application extends Backbone.Marionette.Application
  initialize: =>
    @on 'iniitialize:after', @startHistory

    @start()
    
   startHistory: (options) => Backbone.history.start()

module.exports = Application

