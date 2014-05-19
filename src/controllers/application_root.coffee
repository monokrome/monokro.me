angular.module 'application'
  .controller 'controllers.application_root', [
    '$scope'
    ($scope) -> $scope.name = 'World'
  ]
