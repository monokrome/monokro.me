assets = require 'connect-assets'
express = require 'express'
stylus = require 'stylus'
path = require 'path'

if !process.env.NODE_ENV?
  process.env.NODE_ENV = 'production'

public_dir = (filename) -> path.join __dirname, '../public', filename or ''

exports.apply = (server) ->
  server.assets_context = {}

  server.use express.static public_dir()
  server.use assets
    src: 'assets/'
    helperContext: server.assets_context

  server.assets_context.css.root = 'stylesheets/'
  server.assets_context.js.root = 'scripts/'

  server.set 'views', public_dir 'views'

  server.configure 'development', ->
    this.set 'listening-port', process.env.NODE_PORT || 8000

  server.configure 'production', ->
    this.set 'listening-port', process.env.NODE_PORT || 80

