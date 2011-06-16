var music = require('../music');

function make_client_track_data (message, track)
{
    return {
            'type': 'music_queue_track',
            'autoplay': message.autoplay || false,
            'buffer': message.buffer || false,

            'track': {
                'location': track.get_location(message.format || 'ogg/lo'),
                'name': track.name,
                'index': track.album.tracks.indexOf(track),

                'album': {
                    'index': music.albums.indexOf(track.album)
                }
            }
    };
}

module.exports = {
    'music_random': function get_random_track (message) {
        var random_track = music.get_random_track();

        this.broadcast(make_client_track_data(message, random_track));
    },

    'music_next': function get_next_track (message) {
        if (!message.track || !message.track.index)
        {
            // Sane default - the first track of a random album.
            message.track = {
                index: 0, // Normally -1. 0 for now. (Album intro is unusual)

                album: {
                    index: music.albums.indexOf(music.get_random_album())
                }
            };
        }

        var album = music.albums[message.track.album.index],
            track;

        if (album.tracks.length <= message.track.index)
            track = album.tracks[0];
        else
            track = album.tracks[message.track.index + 1];

        this.broadcast(make_client_track_data(message, track));
    },

    'music_select': function get_specific_track (message) {
        if (!message.track || !message.track.index
            || !message.track.album || !message.track.album.index)
        {
            return;
        }

        var album = music.albums[message.track.album.index],
            track = album.tracks[message.track.index];

        this.broadcast(make_client_track_data(message, track));
    }
};
