assets = require 'connect-assets'
express = require 'express'
stylus = require 'stylus'
path = require 'path'

public_dir = (filename) -> path.join __dirname, '../public', filename or ''

exports.apply = (server) ->
	server.use express.static public_dir()
	server.use assets()

	css.root = '/stylesheets'
	js.root = '/scripts'

	server.set 'views', public_dir 'views'

	server.configure 'production', ->
		this.set 'listening-port', process.env.NODE_PORT || 80

	server.configure 'development', ->
		this.set 'listening-port', process.env.NODE_PORT || 8000

