require.config
  baseUrl: '/scripts/'
  deps: ['application']

  shim:
    angular:
      exports: 'angular'
    
    'angular-ui-router':
      exports: 'angular-ui-router'
      deps: ['angular']
