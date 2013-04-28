exports.config =
  plugins:
    jade:
      options:
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
          'vendor/scripts/jquery-1.9.1.js',
          'vendor/scripts/lodash.underscore.js',
          'vendor/scripts/backbone.js',
          'vendor/scripts/backbone.marionette.js',
          'vendor/scripts/bootstrap.js',
          'vendor/scripts/soundcloud.js'
        ]

    stylesheets:
      joinTo:
        'stylesheets/app.css': /^(app|vendor)/
        'test/stylesheets/test.css': /^test/
      order:
        before: []
        after: []

    templates:
      joinTo: 'javascripts/app.js'
