angular.module 'mk.audio'
  .directive 'mkAudioPlayer', [
    '$sce'
    'mk.audio.services.soundcloud'

  ].concat ($sce, soundcloud) ->
    scope:
      tracks: '=tracks'

    replace: no
    restrict: 'A'
    templateUrl: '/audio/partials/player.html'

    compile: (tElement, tAttrs) ->
      audioElements = []

      post: ($scope, $el, $attrs) ->
        $scope = angular.extend $scope,
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

              audioElement = getAudioElement()

              if audioElement? and wasPlaying
                element = angular.element audioElement

                element.bind 'canplaythrough', ->
                  audioElement.play()
                  element.unbind 'canplaythrough'

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

        $scope.$watchCollection 'tracks', ->
          return if $scope.currentTrack in $scope.tracks
          return if $scope.tracks.length is 0

          $scope.currentTrack = $scope.tracks[0]
