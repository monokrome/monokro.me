angular.module 'application'
  .directive 'applicationRoot', ->
    scope: no
    controller: 'controllers.application_root'
    templateUrl: '/application_root.html'
