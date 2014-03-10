angular.module 'mk.audio'
  .controller 'mk.audio.controller', [
    '$scope'
    'mk.audio.services.soundcloud'

  ].concat ($scope, soundcloud) ->
      angular.extend $scope,
        tracks: []

      # Gets our track list from SoundCloud
      future = soundcloud.track.list 'monokrome'

      future.success (tracks) ->
        $scope.tracks = tracks

        if tracks.length > 0
          $scope.currentTrack = $scope.tracks[0]

      future.error ->
        $scope.tracks = []
        $scope.currentTrack = null
