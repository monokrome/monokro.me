define [], -> ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/blog/'

  $stateProvider.state 'blog',
    url: '/blog/'
    templateUrl: 'blog.html'
