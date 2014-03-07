audio = angular.module 'mk.audio'

audio.directive 'mkAudioPlayer', [
    '$sce'
    'mk.audio.services.soundcloud'
  ].concat ($sce, soundcloud) ->
    scope: yes
    replace: no
    restrict: 'A'
    templateUrl: '/audio/partials/player.html'

    link: ($scope, $el, $attrs) ->
      getAudioElement = ->
        audioElements = $el.find 'audio'
        return audioElements[0] if audioElements.length > 0

      $scope = angular.extend $scope,
        tracks: []

        visible: no

        currentTrack: null

        hasCurrentTrack: -> $scope.currentTrack?
        hasTracks: -> $scope.tracks?.length > 0
        isVisible: -> $scope.hasTracks() and $scope.visible

        show: -> $scope.visible = yes
        hide: -> $scope.visible = no

        toggle: ->
          if $scope.isVisible()
            $scope.hide()
          else
            $scope.show()

        setCurrent: (track) ->
          if $scope.currentTrack isnt track
            wasPlaying = $scope.isPlaying()
            $scope.currentTrack = track

            # if wasPlaying
              # TODO: How do I play the new song?
              # Data binding needs to cause the src to uddate,
              # but I need to mark the element for playback
              # before this $digest cycle finishes. You can't
              # re-call $apply during a $digest cycle, so
              # what do I do?... :/
              

        play: ->
          audioElement = getAudioElement()
          audioElement.play() if audioElement?

        pause: (track) ->
          audioElement = getAudioElement()
          audioElement.pause() if audioElement?

        isPlaying: ->
          element = getAudioElement()

          return !element.paused if element?
          return false

        getStreamURL: ->
          if $scope.currentTrack?
            baseUrl = $scope.currentTrack.stream_url
            streamUrl = baseUrl + '?client_id=' + soundcloud.clientId

            return $sce.trustAsResourceUrl streamUrl

      # Gets our track list from SoundCloud
      future = soundcloud.track.list 'monokrome'

      future.success (tracks) ->
        $scope.tracks = tracks
        $scope.currentTrack = $scope.tracks[0] if tracks.length > 0

      future.error ->
        $scope.tracks = []
        $scope.currentTrack = null

