exports.apply = (server) ->
	server.configure 'production', ->
		this.set 'listening-port', 80

	server.configure 'development', ->
		this.set 'listening-port', 8000
