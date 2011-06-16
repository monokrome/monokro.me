#!/usr/bin/env python

# Converts metadata.json into a usable file for Audalysis to read.
import operator
import json
import os

root_dir = os.path.abspath(os.path.dirname(__file__))

# Gets the json representation of our old metadata
base_metadata_file = open('./metadata.json', 'r')
metadata = json.loads(base_metadata_file.read())
base_metadata_file.close()

# Maps plural event types to a singular event type
event_types = {
    'tatums': 'tatum',
    'beats': 'beat',
    'bars': 'bar',
    'segments': 'segment',
    'sections': 'section',
}

def get_analytic_filename(basename):
    return os.path.abspath(os.sep.join(['{0}',
                                        '..',
                                        'static',
                                        'analysis',
                                        '{1}.json']).format(root_dir, basename))

for track in metadata:
    audalysis_data = { 'meta': {}, 'events': [] }

    if metadata[track]['status'] != 'complete':
        continue

    for event_type in event_types:
        for event in metadata[track]['analysis'][event_type]:
            next_event = { 'type': event_types[event_type] }

            for item in event:
                next_event[item] = event[item]

            audalysis_data['events'].append(next_event)

            filename = get_analytic_filename(metadata[track]['title'].lower())

    audalysis_data['events'].sort(key=operator.itemgetter('start'))

    output_file = open(filename, 'w')
    output_file.write(json.dumps(audalysis_data))
    output_file.close()

    output_file = open('{0}.readable'.format(filename), 'w')
    output_file.write(json.dumps(audalysis_data, indent=4))
    output_file.close()