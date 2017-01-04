import os


from pyramid.paster import get_app
from pyramid.paster import setup_logging


DEFAULT_SETTINGS_FILENAME = os.path.join('etc', 'production.ini')
INI_DIRNAME = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))


CONFIGURATION_PATH = os.path.join(INI_DIRNAME, os.environ.get(
    'SETTINGS_FILENAME',
    DEFAULT_SETTINGS_FILENAME,
))


setup_logging(CONFIGURATION_PATH)
application = get_app(CONFIGURATION_PATH, os.environ.get('service', 'main'))
