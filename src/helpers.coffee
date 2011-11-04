path = require 'path'
latest_twits = require './twitter'

production_environments = ['production']

proper_hostname = (hostname) ->
  hostname

helpers =
	page_title: 'monokro.me'

dynamic_helpers =
  assets: (req, res) ->
    this.assets_context

  latest_twit: (req, res) ->
    hostname = proper_hostname req.headers.host

    if hostname in latest_twits
      latest_twits[hostname]

exports.apply = (server) ->

  server.helpers helpers
  server.dynamicHelpers dynamic_helpers

