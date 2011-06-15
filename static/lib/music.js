define(['realtime'], function define_music (rt) {
    var audio_player = document.getElementById('audio-player'),
        audio_buffer = new Audio(),
        audio_format = 'mp3/lo', // Low-quality MP3 for streaming.

        awaiting_next = true,

        track_info = {}, buffer_track_info = {};

    function request_buffer () {
        // Request the next track in our "playlist" for buffering.
        rt.socket.send({
            type: 'music_next',
            format: audio_format,
            autoplay: false,
            track: track_info,
            buffer: true
        });
    }

    function update_track_info(save_buffer_state)
    {
        var playing_classname = 'playing',
            next_ul, next_li;

        if (!save_buffer_state || audio_player.paused)
        {
            jQuery('#music li.playing').removeClass(playing_classname);
        }

        if (save_buffer_state != true)
        {
            track_info = buffer_track_info;
            buffer_track_info = {};
        }

        if (!audio_player.paused)
        {
            next_ul = jQuery('.album[data-index=' + track_info.album.index + ']'),
            next_li = jQuery(next_ul).find('[data-index=' + track_info.index +']');

            jQuery(next_li).addClass(playing_classname);
        }
    }

    // Creates a new message handler for letting the server change the currently
    // playing track in an arbitrary fashion.
    rt.handlers.music_change_track = (function song_change (message) {
        // Shortcut to our audio player OR audio buffer based on message.
        var ap;

        if (message.buffer == false)
        {
            ap = audio_player;
            track_info = message.track;
        }
        else
        {
            ap = audio_buffer;
            buffer_track_info = message.track;
        }

        ap.src = message.track.location;

        if (ap != audio_buffer)
        {
            ap.autoplay = message.autoplay || false;
            ap.preload = message.preload || 'auto';

            request_buffer();
        }
    });

    // This should never play, as it is used to simply preload a song instead.
    audio_buffer.controls = false;
    audio_buffer.autoplay = false;
    audio_buffer.preload = false;

    /**
     * This makes it so that our buffer will only attempt to preload data when
     * data isn't being preloaded in our audio_buffer (which has priority).
     */
    jQuery(audio_player).bind('loadeddata', function check_loaded () {
        audio_buffer.preload = (audio_player.readyState == 4);
    });

    jQuery(audio_player).bind('ended', function push_buffer () {
        audio_player.src = audio_buffer.src;
        audio_player.autoplay = true;

        request_buffer();

        update_track_info();
    }).bind('play', function on_play () {
        update_track_info(true);
    });

    // When the page first shows up, fires off a request to get a random song.
    // TODO: Maintain current track's state in case that a song was playing
    //       and accidental terminated. This could be a refresh, a bug, etc.
    rt.socket.send({
        type: 'music_next',
        format: audio_format,
        autoplay: false // TODO: Auto-detect.
    });

    return { player: audio_player };
});
