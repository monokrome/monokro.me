define 'application', [
    'angular'
    'configuration'

    'angular-sanitize'
    'angular-ui-router'

    'audio/manifest'

  ], (angular, configuration) ->
    application = angular.module 'mk', [
      'ngSanitize'
      'ui.router'
      'mk.audio'
    ]

    application.config ['$stateProvider', '$urlRouterProvider', configuration]
    return application
