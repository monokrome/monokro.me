{TrackCollection} = require 'models/audio_player'

class NowPlayingView extends Marionette.ItemView
  template: require 'templates/track'

class TrackListItemView extends NowPlayingView
  tagName: 'li'

class TrackListView extends Marionette.CollectionView
  itemView: TrackListItemView
  tagName: 'ul'

class AudioPlayerView extends Marionette.Layout
  template: require 'templates/audio_player'

  regions:
    nowPlaying: '#now-playing'
    trackList: '#track-list'

  ui:
    playButton: '.icon-play'
    pauseButton: '.icon-pause'
    forwardButton: '.icon-forward'
    backwardButton: '.icon-backward'

  initialize: ->
    tracks = new TrackCollection

    tracks.on 'sync', (e) =>
      if !@currentTrack? and tracks.length > 0
        @setCurrentTrack tracks.models[0]

    tracks.fetch()

  setCurrentTrack: (track) ->
    @currenTrack = track

    @nowPlaying.show new NowPlayingView
      model: track

    @nowPlaying.$el.addClass 'active'

module.exports = {
  AudioPlayerView
}

