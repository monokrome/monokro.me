import mock
import unittest

from mk import application


class ApplicationTestCase(unittest.TestCase):
    def test_is_ignored_module_returns_False_when_not_ignored(self):
        self.assertFalse(application.is_ignored_module('views'))

    def test_is_ignored_module_returns_True_for_test_files(self):
        self.assertTrue(application.is_ignored_module('views_spec'))

    def test_main_passes_settings_to_configurator(self):
        example_configuration = {}
        example_settings = {'mock_option': 'true'}

        with mock.patch('pyramid.config.Configurator') as patch:
            application.main(
                example_configuration,
                **example_settings
            )

            patch.assert_called_once()
            patch.assert_called_with(
                root_factory='mk.resources.RootResource',
                settings=example_settings,
            )

    def test_main_returns_wsgi_app(self):
        test_val = {}

        mock_result = mock.MagicMock()
        mock_result.make_wsgi_app.return_value = test_val

        with mock.patch('pyramid.config.Configurator') as patch:
            patch.return_value = mock_result
            result = application.main({})

        self.assertIs(test_val, result)
