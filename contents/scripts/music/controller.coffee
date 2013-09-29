models = require './models.coffee'
views = require './views.coffee'


class MusicController extends Backbone.Marionette.Controller
  audioElement: jQuery '<audio>'

  playlistLoaded: =>
    if !@currentTrack? and @playlist.length > 0
      @player.$el.addClass 'active'
      @setCurrentTrack @playlist.at 0

      @player.trackList.show new views.TracksView
        collection: @playlist

      @player.ui.playlist.sidebar 'setting', 'overlay', true

    else
      @$el.removeClass 'active'

  play: =>
    @$body.addClass 'visualizer' if @shouldVisualize()

    @player.$el.removeClass 'paused'
    @player.$el.addClass 'playing'

    if @audioElement.get(0).paused
      @audioElement.get(0).play()

  pause: =>
    @$body.removeClass 'visualizer'

    @player.$el.removeClass 'playing'
    @player.$el.addClass 'paused'

    if not @audioElement.get(0).paused
      @audioElement.get(0).pause()

  setCurrentTrack: (track) ->
    if @currentTrack? and @currentTrack is track
      return

    @currentTrack = track

    @player.nowPlaying.show new views.NowPlayingView
      model: track

    @audioElement.attr 'src', @getMusicSource track

    if @player.$el.hasClass 'playing'
      @audioElement.get(0).play()

  trackChanged: (trackView) =>
    @setCurrentTrack trackView.model

    if not @audioElement.get(0).playing
      @play()

  getMusicSource: (track) ->
    baseUrl = track.get "stream_url"
    return baseUrl + '?client_id=c5c77f52385776590f11e7546f2c3c87'

  shiftCurrentTrack: (amount) ->
    position = @playlist.models.indexOf @currentTrack
    length = @playlist.length

    # Increment by amount (+1 for length comparisons)
    position = (position + 1) + amount

    # Wrap if at the end of the list
    if position > length
      position = 1

    if position < 1
      position = length

    # Account for zero-based indexing
    position -= 1

    @setCurrentTrack @playlist.at position

  forward: => @shiftCurrentTrack 1
  backward: => @shiftCurrentTrack -1

  togglePlaylist: =>
    @player.ui.playlistButton.toggleClass 'active'

    @player.ui.playlist.sidebar 'toggle', =>
      @player.trackList.currentView.on 'itemview:selected', @trackChanged

  shouldVisualize: ->
    local = localStorage.getItem 'music.visualize'

    unless local is 'true'
      local = sessionStorage.getItem 'music.visualize'

    return local

  initialize: ->
    @$body = jQuery document.body
    @audioElement.bind 'ended', @forward

    @options.application.addRegions
      audioPlayer: '#audio-player-container'

    @playlist = new models.Tracks

    @player = new views.MusicPlayerView
      collection: @playlist

    @playlist.on 'sync', @playlistLoaded

    @player.on 'play', @play
    @player.on 'pause', @pause

    @player.on 'forward', @forward
    @player.on 'backward', @backward

    @player.on 'closePlaylist', @closePlaylist
    @player.on 'togglePlaylist', @togglePlaylist

    @options.application.audioPlayer.show @player
    @playlist.fetch()


module.exports = {
  Controller: MusicController
}
