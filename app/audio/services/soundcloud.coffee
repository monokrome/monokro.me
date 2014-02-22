define ['angular'], (angular) ->
  soundcloud = ($http) ->
    service =
      tracks: (username) ->
        $http.get 'http://api.soundcloud.com/users/' + username + '/tracks',
          data:
            clientId: 'c5c77f52385776590f11e7546f2c3c87'

  angular.directive ['$http', soundcloud]
