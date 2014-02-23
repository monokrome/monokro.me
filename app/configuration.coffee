define [], -> ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise '/blog/'

  $stateProvider.state 'blog',
    url: '/blog/'
    views:
      primary:
        templateUrl: '/blog.html'
