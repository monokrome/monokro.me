models = require './models.coffee'


class NowPlayingView extends Backbone.Marionette.ItemView
  template: require './templates/track.js'


class TrackView extends Backbone.Marionette.ItemView
  tagName: 'li'
  template: require './templates/tracklist_track.js'

  events:
    'click a': 'selected'

  selected: (item) ->
    @trigger 'selected'


class TracksView extends Backbone.Marionette.CollectionView
  itemView: TrackView
  tagName: 'ul'

  onRender: ->
    @$el.addClass 'nav'
    @$el.addClass 'nav-stacked'


class AudioPlayerView extends Backbone.Marionette.Layout
  template: require './templates/audio_player.js'

  id: 'audio-player'
  tagName: 'section'

  regions:
    nowPlaying: '#now-playing'
    trackList: '#track-list'

  ui:
    playlist: '#track-selection'

    playButton: '.btn-play'
    pauseButton: '.btn-pause'
    forwardButton: '.btn-forward'
    backwardButton: '.btn-backward'
    playlistButton: '.btn-playlist'

  audioElement: jQuery('<audio>')

  events:
    'click .btn-play': 'play'
    'click .btn-pause': 'pause'
    'click .btn-forward': 'forward'
    'click .btn-backward': 'backward'
    'click .btn-playlist': 'togglePlaylist'
    'click #track-selection .btn-close': 'closePlaylist'

  initialize: ->
    @audioElement.bind 'ended', => @shiftCurrentTrack 1

    @collection = new models.Tracks

    @collection.on 'sync', (e) =>
      if !@currentTrack? and @collection.length > 0
        @$el.addClass 'active'
        @setCurrentTrack @collection.models[0]

      else
        @$el.removeClass 'active'

    @collection.fetch()

  getAudioSource: (track) ->
    track.get("stream_url") + '?client_id=c5c77f52385776590f11e7546f2c3c87'

  setCurrentTrack: (track) ->
    if @currentTrack? and @currentTrack is track
      return

    @currentTrack = track

    @nowPlaying.show new NowPlayingView
      model: track

    @audioElement.attr 'src', @getAudioSource track

    if @$el.hasClass 'playing'
      @audioElement.get(0).play()

  shiftCurrentTrack: (amount) ->
    position = @collection.models.indexOf @currentTrack
    length = @collection.models.length

    position = (position + 1) + amount

    if position > length
      position = 1

    if position < 1
      position = length

    @setCurrentTrack @collection.models[position - 1]

  forward: -> @shiftCurrentTrack 1
  backward: -> @shiftCurrentTrack -1

  play: =>
    @$el.removeClass 'paused'
    @$el.addClass 'playing'

    if @audioElement.get(0).paused
      @audioElement.get(0).play()

  pause: =>
    @$el.removeClass 'playing'
    @$el.addClass 'paused'

    if not @audioElement.get(0).paused
      @audioElement.get(0).pause()

  trackChanged: (trackView) =>
    @setCurrentTrack trackView.model

    if not @audioElement.get(0).playing
      @play()

  displayPlaylist: ->
    @trackList.show new TracksView
      collection: @collection

    @trackList.currentView.on 'itemview:selected', @trackChanged

    @ui.playlist.addClass 'active'

  closePlaylist: ->
    @ui.playlist.removeClass 'active'

    if @trackList.currentView?
      @trackList.currentView.close()

    # This needs manually unset for togglePlaylist to work properly
    delete @trackList.currentView

  togglePlaylist: ->
    if @trackList.currentView?
      @closePlaylist()

    else
      @displayPlaylist()


module.exports = {
  AudioPlayerView
}
