angular.module 'mk.audio'
  .directive 'mkAudioPlayer', [
    '$sce'
    'mk.audio.services.soundcloud'

  ].concat ($sce, soundcloud) ->
    scope: {}
    replace: yes

    templateUrl: '/audio/index.html'
    controller: 'mk.audio.controller'

    compile: ->
      $body = jQuery 'body'

      post: ($scope) ->
        angular.extend $scope,
          playingClass: 'visualizer'
          updatePlayState: (playing) ->
            $body.addClass $scope.playingClass if playing
            $body.removeClass $scope.playingClass unless playing

