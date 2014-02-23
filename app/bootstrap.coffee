define 'bootstrap', [
  'ready'
  'angular'
  'application'
], (domReady, angular, application) ->
  domReady -> angular.bootstrap document, ['mk']
