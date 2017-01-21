import json

from six.moves import urllib


WORDPRESS_API_TEMPLATE = 'https://public-api.wordpress.com/wp/v2/sites/{site}/'


class Wordpress(object):
    """ Generic client for requesting data from WordPress."""

    def __init__(self, site_identifier):
        self.root_endpoint = WORDPRESS_API_TEMPLATE.format(
            site=site_identifier,
        )

    def _get_query_string(self, **query):
        if not query:
            return ''

        return '?' + urllib.parse.urlencode(query)

    def get_service_url(self, *path_segments, **query):
        path = '/'.join(path_segments) + '/'
        return self.root_endpoint + path + self._get_query_string(**query)

    def request(self, *path_segments, **query):
        service_url = self.get_service_url(*path_segments, **query)
        return json.loads(urllib.request.urlopen(service_url).read())

    def get_posts(self):
        return self.request('posts')
