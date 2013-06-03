{AudioPlayerView} = require 'views/audio_player'

class Application extends Backbone.Marionette.Application
  components: ['blog']

  initialize: =>
    @addInitializer @initializeRegions
    @addInitializer @initializeRouting
    @addInitializer @initializeAudioPlayer

    @on 'initialize:after', @startHistory

    @start()
    @freeze?()

  startHistory: => Backbone.history.start()

  initializeRegions: =>
    @addRegions
      audioPlayer: '#audio-player-container'
      contentContainer: '#content-container'

  initializeRouting: =>
    componentData = []

    for component in @components
      {Router} = require "routers/#{component}"
      {Controller} = require "controllers/#{component}"

      controller = new Controller
        application: @

      router = new Router
        controller: controller

      componentData[component] = {
        router
        controller
      }

    @componentData = componentData

  initializeAudioPlayer: =>
    @audioPlayer.show new AudioPlayerView

module.exports = Application
