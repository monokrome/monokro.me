import os
import unittest

from pyramid import router

from mk import wsgi


class WSGITestCase(unittest.TestCase):
    def test_wsgi_settings_default_to_production(self):
        self.assertIsInstance(wsgi.application, router.Router)

    def test_wsgi_configuration_path_defaults_to_production(self):
        file_directory = os.path.dirname(__file__)
        project_path = os.path.abspath(os.path.join(file_directory, '..'))
        expectation = os.path.join(project_path, 'etc', 'production.ini')
        self.assertEqual(wsgi.CONFIGURATION_PATH, expectation)
