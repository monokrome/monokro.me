var winston = require('winston'),
    Track = require('./track'),
    media_url = 'http://media.monokro.me/audio/albums/',

    albums = [
        {
            name: 'Robotik',
            released: new Date(2009, 9, 17, 23, 30).getTime(),
            formats: [ 'flac', 'mp3/hi', 'mp3/lo', 'ogg/hi', 'ogg/lo' ],

            download_formats: {
                'flac': 'flac',
                'mp3/hi': 'mp3',
                'ogg/hi': 'ogg'
            },
    
            tracks: [
                new Track('Initialize'),
                new Track('Robotik'),
                new Track('Realization'),
                new Track('Inspiration'),
                new Track('Transmission'),
                new Track('The Gathering'),
                new Track('March' ),
                new Track('Finding Hope'),
                new Track('Destroy'),
                new Track('Reboot')
            ]
        }
    ],

    album_index, album,
    track_index, track;

// Initialize other album metadata
for (album_index in albums)
{
    album = albums[album_index];

    // Define the URI to this album's root
    if (typeof album.location == 'undefined')
    {
        album.location = media_url
                         + new Date(album.released).getFullYear() + ' '
                         + album.name;
    }

    for (track_index in album.tracks)
    {
        track = album.tracks[track_index];

        // Generate a track number for this track
        if (typeof track.number == 'undefined')
        {
            track.number = parseInt(track_index) + 1;
        }

        // Set the track's album
        if (typeof track.album == 'undefined')
        {
            track.album = album;
        }
    }
}

function get_random_album ()
{
    return albums[parseInt(Math.random() * albums.length)];
}

function get_random_track (_album)
{
    // Get a random album if one isn't provided.
    var album = _album || get_random_album();

    // Return a random track from within that album.
    return album.tracks[parseInt(Math.random() * album.tracks.length)];
}

module.exports = {
    albums: albums,

    get_random_album: get_random_album,
    get_random_track: get_random_track
};
