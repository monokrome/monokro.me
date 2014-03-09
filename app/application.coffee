angular
  .module 'mk', [
    'ngSanitize'
    'ui.router'
    'templates'
    'mk.audio'
  ]

  .config [
    '$stateProvider'
    '$urlRouterProvider'

  ].concat ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise '/blog/'

    $stateProvider.state 'blog',
      url: '/blog/'
      views:
        primary:
          templateUrl: '/blog.html'
