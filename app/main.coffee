require.config
  baseUrl: '/scripts/'
  deps: ['bootstrap']

  shim:
    angular:
      exports: 'angular'
    
    'angular-sanitize':
      exports: 'angular-sanitize'
      deps: ['angular']

    'angular-ui-router':
      exports: 'angular-ui-router'
      deps: ['angular']
