express = require 'express'
stylus = require 'stylus'
path = require 'path'

public_dir = (filename) -> path.join __dirname, '../public', filename or ''

get_stylus_options = (server) ->
	stylus_options =
		compress: server.env == 'production'
		debug: server.env != 'production'
		force: server.env != 'production'
		linenos: server.env != 'production'
		firebug: server.env != 'production'
		src: path.join __dirname
		dest: public_dir()

exports.apply = (server) ->
	server.use express.static public_dir()
	server.use stylus.middleware get_stylus_options server
	server.set 'views', public_dir 'views'

	server.configure 'production', ->
		this.set 'listening-port', process.env.NODE_PORT || 80

	server.configure 'development', ->
		this.set 'listening-port', process.env.NODE_PORT || 8000

