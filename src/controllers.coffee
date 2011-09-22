exports.apply = (server) ->

	# A simple example view.
	server.get '/', (req, res, next) ->
		res.render 'home.jade'

