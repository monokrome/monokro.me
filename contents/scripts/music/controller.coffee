models = require './models.coffee'
views = require './views.coffee'


class MusicController extends Backbone.Marionette.Controller
  initialize: ->
    application = @options.application

    application.addRegions
      audioPlayer: '#audio-player-container'

    _.defer ->
      application.audioPlayer.show new views.AudioPlayerView


module.exports = {
  Controller: MusicController
}
