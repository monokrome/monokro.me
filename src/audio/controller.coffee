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
      player: null
      playlist: []

      viewingPlayList: no
      toggleTrackView: -> $scope.viewingPlayList = not $scope.viewingPlayList

      hasTracks: -> $scope.playlist.length > 0

    onSuccess = (response) ->
      $scope.playlist = response.data.map (track) ->
        src: getStream track
        track: track
        type: 'audio/mp3'

    onError = -> $scope.playlist = []

    soundcloud.track.list 'monokrome'
      .then onSuccess, onError
