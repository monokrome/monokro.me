angular
  .module 'mk', [
    'audioPlayer'
    'ngSanitize'

    'ui.router'

    'templates'
    'mk.audio'
  ]

  .config [
    '$stateProvider'
    '$urlRouterProvider'
    '$locationProvider'

  ].concat ($stateProvider, $urlRouterProvider, $locationProvider) ->
    $locationProvider.html5Mode true
    $urlRouterProvider.otherwise '/blog/'
