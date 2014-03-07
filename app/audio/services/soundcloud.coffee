audio = angular.module 'mk.audio'

audio.factory 'mk.audio.services.soundcloud', [
  '$http'
].concat ($http) ->
  clientId: 'c5c77f52385776590f11e7546f2c3c87'
  track:
    list: (username) ->
      $http.get 'http://api.soundcloud.com/users/' + username + '/tracks',
        params:
          client_id: 'c5c77f52385776590f11e7546f2c3c87'

