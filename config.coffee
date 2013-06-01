exports.config =
  plugins:
    jaded:
      staticPatterns: /^app(\/|\\)static(\/|\\)(.+)\.jade$/
      jade:
        pretty: no

    static_jade:
      extension: '.static.jade'

  # See http://brunch.readthedocs.org/en/latest/config.html for documentation.
  files:
    javascripts:
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^vendor/
        'test/javascripts/test.js': /^test(\/|\\)(?!vendor)/
        'test/javascripts/test-vendor.js': /^test(\/|\\)(?=vendor)/
      order:
        before: [
          'vendor/scripts/jquery-1.9.1.js'
          'vendor/scripts/lodash.underscore.js'
          'vendor/scripts/backbone.js'
          'vendor/scripts/backbone.marionette.js'
          'vendor/scripts/backbone.paginator.js'
          'vendor/scripts/bootstrap.js'
          'vendor/scripts/soundcloud.js'
        ]

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^(app|vendor)/
        'test/stylesheets/test.css': /^test/
      order:
        before: [
          'vendor/styles/bootstrap.css',
          'vendor/styles/bootstrap-responsive.css',
        ]
        after: []

    templates:
      joinTo:
        'javascripts/articles.js': /^app(\/|\\)articles(\/||\\).+/
        'javascripts/templates.js': /^app(\/|\\)templates(\/||\\).+/
