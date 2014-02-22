define 'application', [
    'ready'
    'angular'
    'routes'
    'angular-ui-router'
  ], (domReady, angular, routes) ->

    application = angular.module 'mk', ['ui.router']

    # I'm pretty sure that this wont be required, but only beecause
    # I think that the DOM will always win the race. :D
    domReady ->
      application.config ['$stateProvider', '$urlRouterProvider', routes]
      angular.bootstrap document, ['mk']

    return application
