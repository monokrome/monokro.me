path = require 'path'

production_environments = ['production']

helpers =
	page_title: 'My Website'
	script_url: (name) ->
		url = '/'
		url = url + ['scripts', (this.app.set 'env'), name].join '/'

		if this.app.set 'env' in production_environments
			url = url + '.min.js'

		url = url + '.js'

		return url

dynamic_helpers =

exports.apply = (server) ->

	server.helpers helpers
	server.dynamicHelpers dynamic_helpers

