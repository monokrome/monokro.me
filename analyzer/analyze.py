#!/usr/bin/env python

#
# This is a small script which can be used to recursively loop through
# a directory and analyze every piece of audio in that directory using
# the impressive EchoNest API (http://the.echonest.com/).
#
# After completion, it will write a file in this script's directory
# which contains a mapping of every absolute file path analyzed and
# the related MD5 and title attributes of the resulting track. You
# can then use these MD5s in your own projects to reference the final
# analysis data over the EchoNest API.
#
# This also now stores some interesting information from the API
# into the JSON. This includes most of the analysis data (I figure
# that I probably missed something) as well as the bitrate, song title,
# artist, etc.
#
# This was created with the current development version of PyEchoNest.
#

#!/usr/bin/env python

from pyechonest import track, song
import os
import json

analysis_dir = os.path.abspath(os.path.dirname(__file__))

dir_segments = [
    analysis_dir,
    'audio',
]

allowed_file_extensions = ['.flac', '.mp3', '.ogg', '.wav']

audio_dir = os.sep.join(dir_segments)

if not os.path.exists(audio_dir):
    raise ValueError('Directory does not exist: {0}'.format(audio_dir))

if not os.path.isdir(audio_dir):
    raise ValueError('File must be a directory: {0}'.format(audio_dir))

meta_data = {}

def analyze_audio(dir_name):

    for filename in os.listdir(dir_name):
        absolute_path = os.sep.join([
            dir_name,
            filename
        ])

        print('Creating track from: {0}'.format(absolute_path))

        if os.path.isdir(absolute_path):
            analyze_audio(absolute_path)

        elif os.path.splitext(filename)[1] in allowed_file_extensions:
            next_track = track.track_from_filename(absolute_path)

            if next_track is not None:
                meta_data[absolute_path] = {
                    'id': next_track.id,
                    'md5': next_track.md5,
                    'status': next_track.status,
                    'title': next_track.title,
                    'artist': next_track.artist,

                    'analysis': {
                        'status': next_track.status,
                        'tatums': next_track.tatums,
                        'segments': next_track.segments,
                        'sections': next_track.sections,
                        'beats': next_track.beats,
                        'bars': next_track.bars,
                        'danceability': next_track.danceability,
                        'bitrate': next_track.bitrate,
                        'url': next_track.analysis_url,
                        'channels': next_track.analysis_channels,
                        'loudness': next_track.loudness,
                        'energy': next_track.energy,

                        'time_signature': {
                            'estimate': next_track.time_signature,
                            'confidence': next_track.time_signature_confidence,
                        },
                        'tempo': {
                            'estimate': next_track.tempo,
                            'confidence': next_track.tempo_confidence
                        },
                        'key': {
                            'estimate': next_track.key,
                            'confidence': next_track.key_confidence,
                        },
                        'mode': {
                            'estimate': next_track.mode,
                            'confidence': next_track.mode_confidence,
                        },
                        'fading': {
                            'start': next_track.start_of_fade_out,
                        },
                        'samples': {
                            'rate': next_track.samplerate,
                            'analysis_rate': next_track.analysis_sample_rate,
                            'count': next_track.num_samples,
                        },
                    }
                }

analyze_audio(audio_dir)

meta_file = open(os.sep.join([analysis_dir, 'metadata.json']), 'w')
meta_file.write(json.dumps(meta_data))
meta_file.close()
