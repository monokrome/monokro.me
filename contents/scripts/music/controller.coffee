models = require './models.coffee'
views = require './views.coffee'


class MusicController extends Backbone.Marionette.Controller
  initialize: ->
    @options.application.addRegions
      audioPlayer: '#audio-player-container'

    @options.application.audioPlayer.show new views.AudioPlayerView


module.exports = {
  Controller: MusicController
}
