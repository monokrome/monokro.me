express = require 'express'
path = require 'path'

public_dir = (filename) -> path.join __dirname, '../public', filename or ''

exports.apply = (server) ->
	server.use express.static public_dir()
	server.set 'views', public_dir 'views'

	server.configure 'production', ->
		this.set 'listening-port', 80

	server.configure 'development', ->
		this.set 'listening-port', 8000
