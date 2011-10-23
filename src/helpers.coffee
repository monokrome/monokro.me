path = require 'path'

production_environments = ['production']

helpers =
	page_title: 'monokro.me'

dynamic_helpers =
  assets: (req, res) ->
    this.assets_context

exports.apply = (server) ->

  server.helpers helpers
  server.dynamicHelpers dynamic_helpers

