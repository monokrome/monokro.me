angular.module 'mk.audio'
  .controller 'mk.audio.controller', [
    '$scope'
    '$sce'
    'mk.audio.services.soundcloud'

  ].concat ($scope, $sce, soundcloud) ->
    getStream = (track) ->
      return track.stream_url + '?client_id=' + soundcloud.clientId
      return $sce.trustAsResourceUrl baseUrl

    angular.extend $scope,
      hasTracks: -> $scope.playlist.length > 0
      viewingPlayList: -> $scope.player?.playing

    onSuccess = (response) ->
      $scope.playlist = response.data.map (track) ->
        src: getStream track
        track: track
        type: 'audio/mp3'

    onError = -> $scope.playlist = []

    soundcloud.track.list 'monokrome'
      .then onSuccess, onError

    $scope.$watch 'player', (player) ->
      player.$watch 'playing', $scope.updatePlayState if player?
