models = require './models.coffee'
views = require './views.coffee'


$body = jQuery 'body'


class MusicController extends Backbone.Marionette.Controller
  audioElement: jQuery '<audio>'

  playlistLoaded: =>
    if !@currentTrack? and @playlist.length > 0
      @player.$el.addClass 'active'
      @setCurrentTrack @playlist.at 0

    else
      @$el.removeClass 'active'

  play: =>
    $body.addClass 'promo'

    @player.$el.removeClass 'paused'
    @player.$el.addClass 'playing'

    if @audioElement.get(0).paused
      @audioElement.get(0).play()

  pause: =>
    $body.removeClass 'promo'

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

    @audioElement.attr 'src', @getAudioSource track

    if @player.$el.hasClass 'playing'
      @audioElement.get(0).play()

  trackChanged: (trackView) =>
    @setCurrentTrack trackView.model

    if not @audioElement.get(0).playing
      @play()

  getAudioSource: (track) ->
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
    if @player.trackList.currentView?
      @closePlaylist()

    else
      @displayPlaylist()

  displayPlaylist: ->
    @player.trackList.show new views.TracksView
      collection: @playlist

    @player.trackList.currentView.on 'itemview:selected', @trackChanged
    @player.ui.playlist.addClass 'active'

  closePlaylist: =>
    @player.ui.playlist.removeClass 'active'

    if @player.trackList.currentView?
      @player.trackList.currentView.close()

    # This needs manually unset for togglePlaylist to work properly
    delete @player.trackList.currentView

  initialize: ->
    @audioElement.bind 'ended', @forward

    @options.application.addRegions
      audioPlayer: '#audio-player-container'

    @playlist = new models.Tracks

    @player = new views.AudioPlayerView
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
