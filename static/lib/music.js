/**
 * TODO: This is a pretty messy file. Let's tidy it up a bit.
 *                          s/bit/lot/
 */
define(['realtime'], function define_music (rt) {
    var audio_player = new Audio(), // Plays our audio
        audio_buffer = new Audio(), // Buffers our audio for gapless playback
        audio_format = 'mp3/lo', // Low-quality MP3 for streaming.

        awaiting_next = true,

        track_info = {}, buffer_track_info = {},

        playing_classname = 'playing',
        paused_classname = 'paused';

    // We probably wont need this, but it might help support 3rd party libraries
    // in the future.
    audio_player.id = 'audio-player';

    /**
     * Sends a request to our server for the next song.
     */
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

    /**
     * This does all of the work needed to update track information, as well as
     * updates the classnames of any elements that need to be aware of the audio
     * state in our file.
     */
    function update_track_info(save_buffer_state)
    {
        var next_ul, next_li;

        if (!save_buffer_state || audio_player.paused)
        {
            jQuery('#music li.playing, #music li.paused')
                                       .removeClass(playing_classname)
                                       .removeClass(paused_classname);
        }

        if (save_buffer_state != true)
        {
            track_info = buffer_track_info;
            buffer_track_info = {};
        }

        next_ul = jQuery('.album[data-index=' + track_info.album.index + ']'),
        next_li = jQuery(next_ul).find('[data-index=' + track_info.index +']');

        if (!audio_player.paused)
        {
            jQuery(next_li).addClass(playing_classname)
                           .removeClass(paused_classname);
        }
        else
        {
            jQuery(next_li).addClass(paused_classname)
                           .removeClass(playing_classname);
        }
    }

    // Creates a new message handler for letting the server change the currently
    // playing track in an arbitrary fashion.
    rt.handlers.music_queue_track = (function song_change (message) {
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

        update_track_info(true);
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
    }).bind('pause', function on_pause () {
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

    jQuery('#music ul.album > li').bind('click', function on_click_track (e) {
        var track_index = jQuery(this).attr('data-index'),
            album_index = jQuery(this).parent().attr('data-index');

        // If we paused the audio or it is loaded BUT hasn't played - then play.
        if (jQuery(this).hasClass(paused_classname)
            || (track_index == track_info.index
                && album_index == track_info.album.index
                && audio_player.paused))
        {
            audio_player.play();
            update_track_info(true);

            return e.stopPropagation();
        }

        // Next, if this is the currently playing track - pause it.
        if (jQuery(this).hasClass(playing_classname))
        {
            audio_player.pause();
            update_track_info(true);

            return e.stopPropagation();
        }

        // If all other possibilities are exhausted, ask the server for the song
        // that we've chosen to play.
        rt.socket.send({
            type: 'music_select',
            format: audio_format,
            autoplay: true,

            track: {
                index: track_index,

                album: {
                    index: album_index
                }
            }
        });

        return e.stopPropagation();
    });

    return { player: audio_player };
});
