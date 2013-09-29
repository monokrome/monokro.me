models = require './models.coffee'

class NowPlayingView extends Backbone.Marionette.ItemView
  template: require './templates/track.jade'


class TrackView extends Backbone.Marionette.ItemView
  tagName: 'li'
  className: 'item link'
  template: require './templates/tracklist_track.jade'

  triggers:
    'click a': 'selected'


class TracksView extends Backbone.Marionette.CollectionView
  tagName: 'ul'
  itemView: TrackView
  itemViewEventPrefix: 'track'

  initialize: ->
    @$body = jQuery document.body
    @$body.dimmer 'setting', 'onHide', =>
      unless @isClosed
        @close()

  onShow: -> @$body.dimmer 'show'
  onClose: -> @$body.dimmer 'hide'


class MusicPlayerView extends Backbone.Marionette.Layout
  template: require './templates/audio_player.jade'

  id: 'music-player'
  tagName: 'section'

  regions:
    nowPlaying: '#now-playing'
    playlist: '#track-list'

  ui:
    playlist: '#track-selection'
    playButton: '.button.play'
    pauseButton: '.button.pause'
    forwardButton: '.button.forward'
    backwardButton: '.button.backward'
    playlistButton: '.button.playlist'

  triggers:
    'click .button.play': 'play'
    'click .button.pause': 'pause'
    'click .button.forward': 'forward'
    'click .button.backward': 'backward'
    'click .button.playlist': 'togglePlaylist'


module.exports = {
  MusicPlayerView
  NowPlayingView

  TrackView
  TracksView
}
