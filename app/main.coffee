require.config
  baseUrl: '/scripts/'
  deps: ['bootstrap']

  shim:
    angular:
      exports: 'angular'
    
    'angular-sanitize':
      deps: ['angular']

    'angular-ui-router':
      deps: ['angular']
