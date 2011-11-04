path = require 'path'
latest_twits = require './twitter'

production_environments = ['production']

proper_hostname = (hostname) ->
  return hostname

helpers =
	page_title: 'monokro.me'

development_status =
  text: "Hello. This would normally be somebody's status update. However, in " +
        "development mode - it's just a tiny 140 character piece of " +
        "example text."
  user:
    screen_name: "nobody"

dynamic_helpers =
  assets: (req, res) ->
    this.assets_context

  latest_twit: (req, res) ->
    hostname = proper_hostname req.headers.host

    if hostname in latest_twits
      return latest_twits[hostname]

    else if process.env.NODE_ENV is 'development'
      return development_status

exports.apply = (server) ->

  server.helpers helpers
  server.dynamicHelpers dynamic_helpers

