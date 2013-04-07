class TrackModel extends Backbone.Model
  url: 'http://api.soundcloud.com/users/monokrome/tracks'

  fetch: (options) ->
    options = _.extend {}, options, 
      data:
        client_id: 'c5c77f52385776590f11e7546f2c3c87'

    super options

class TrackCollection extends Backbone.Collection
  url: 'http://api.soundcloud.com/users/monokrome/tracks'
  model: TrackModel

  fetch: (options) ->
    options = _.extend {}, options, 
      data:
        client_id: 'c5c77f52385776590f11e7546f2c3c87'

    super options

module.exports = {
  TrackModel
  TrackCollection
}

