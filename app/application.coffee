{AudioPlayerView} = require 'views/audio_player'

class Application extends Backbone.Marionette.Application
  initialize: =>
    @addInitializer @initializeAudioPlayer

    @on 'initialize:after', @startHistory

    @start()
    
  startHistory: (options) => Backbone.history.start()

  initializeAudioPlayer: =>
    @addRegions
      audioPlayer: '#audio-player'

    @audioPlayer.show new AudioPlayerView

module.exports = Application

