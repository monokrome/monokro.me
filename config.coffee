exports.config =
  # See http://brunch.readthedocs.org/en/latest/config.html for documentation.
  modules:
    wrapper: false
    definition: false

  files:
    javascripts:
      joinTo:
        'scripts/main.js': /^app/
        'scripts/vendor.js': /^vendor/
        'test/scripts/test.js': /^test(\/|\\)(?!vendor)/
        'test/scripts/test-vendor.js': /^test(\/|\\)(?=vendor)/
      order:
        before: [
          'vendor/scripts/modernizr.js',
          'vendor/scripts/typeface.js',
          'vendor/scripts/three.js'
          'vendor/scripts/jquery-1.8.2.js',
        ]
        after: [
          'vendor/scripts/source_sans_pro_regular.typeface',
        ]

    stylesheets:
      joinTo:
        'styles/common.css': /^(app|vendor)/
        'test/styles/test.css': /^test/
      order:
        before: []
        after: []

    templates:
      joinTo: 'scripts/application.js'
