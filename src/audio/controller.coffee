angular.module 'mk.audio'
  .controller 'mk.audio.controller', [
    '$scope'
    '$sce'
    'mk.audio.services.soundcloud'

  ].concat ($scope, $sce, soundcloud) ->
      angular.extend $scope,
        viewingTracks: no
        toggleTrackView: -> $scope.viewingTracks = not $scope.viewingTracks

        tracks: []

        hasTracks: -> $scope.tracks.length > 0
        getStream: (track) ->
          baseUrl = track.stream_url + '?client_id=' + soundcloud.clientId
          return $sce.trustAsResourceUrl baseUrl

      # Gets our track list from SoundCloud
      future = soundcloud.track.list 'monokrome'

      future.success (tracks) ->
        $scope.tracks = tracks

        $scope.playlist = tracks.map (track, i) ->
          src: $scope.getStream track
          track: track
          type: 'audio/mp3'

      future.error ->
        $scope.tracks = []

      $scope.$watch 'player', (changed) ->
        console.log changed
