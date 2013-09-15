class SoundCloudService
  fetch: (options) ->
    options = _.extend {}, options,
      data:
        client_id: 'c5c77f52385776590f11e7546f2c3c87'

    super options



class Track extends Backbone.Model
  url: 'http://api.soundcloud.com/users/monokrome/tracks'

  constructor: ->
    _.extend @, new SoundCloudService


class Tracks extends Backbone.Collection
  url: 'http://api.soundcloud.com/users/monokrome/tracks'
  model: Track

  constructor: ->
    _.extend @, new SoundCloudService


module.exports = {Track, Tracks}


module.exports = {}