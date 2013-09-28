models = require './models.coffee'

class NowPlayingView extends Backbone.Marionette.ItemView
  template: require './templates/track.jade'


class TrackView extends Backbone.Marionette.ItemView
  tagName: 'li'
  template: require './templates/tracklist_track.jade'

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
  template: require './templates/audio_player.jade'

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

  triggers:
    'click .btn-play': 'play'
    'click .btn-pause': 'pause'
    'click .btn-forward': 'forward'
    'click .btn-backward': 'backward'
    'click .btn-playlist': 'togglePlaylist'
    'click #track-selection .btn-close': 'closePlaylist'


module.exports = {
  AudioPlayerView
  NowPlayingView

  TrackView
  TracksView
}
