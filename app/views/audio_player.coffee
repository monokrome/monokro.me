{TrackCollection} = require 'models/audio_player'

class NowPlayingView extends Marionette.ItemView
  template: require 'templates/track'

class TrackListItemView extends Marionette.ItemView
  tagName: 'li'
  template: require 'templates/tracklist_track'

  events:
    'click a': 'selected'

  selected: (item) ->
    @trigger 'selected'

class TrackListView extends Marionette.CollectionView
  itemView: TrackListItemView
  tagName: 'ul'

  onRender: ->
    @$el.addClass 'nav'
    @$el.addClass 'nav-stacked'

class AudioPlayerView extends Marionette.Layout
  template: require 'templates/audio_player'

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
    'click .btn-playlist': 'displayPlaylist'
    'click #track-selection .btn-close': 'closePlaylist'

  initialize: ->
    @collection = new TrackCollection

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

    @nowPlaying.show new NowPlayingView
      model: track

    @audioElement.attr 'src', @getAudioSource track

    if @$el.hasClass 'playing'
      @audioElement.get(0).play()

  shiftCurrentTrack: (amount) ->
    position = @trackList.currentView.collection.models.indexOf @currentTrack
    length = @trackList.currentView.collection.models.length

    position += amount

    if position > length
      position = 1

    if position < 1
      position = length

    @setCurrentTrack @trackList.currentView.collection.models[position - 1]

  forward: -> @shiftCurrentTrack 1
  backward: -> @shoftCurrentTrack -1

  play: ->
    @$el.addClass 'playing'
    @$el.removeClass 'paused'

    if @audioElement.get(0).paused
      @audioElement.get(0).play()

  pause: ->
    @$el.removeClass 'playing'
    @$el.addClass 'paused'

    if not @audioElement.get(0).paused
      @audioElement.get(0).play()

  displayPlaylist: ->
    @trackList.show new TrackListView
      collection: @collection

    @trackList.currentView.on 'itemview:selected', (trackView) =>
      @setCurrentTrack trackView.model

    @ui.playlist.addClass 'active'

  closePlaylist: ->
    @ui.playlist.removeClass 'active'

    if @trackList.currentView?
      @trackList.currentView.close()

module.exports = {
  AudioPlayerView
}

