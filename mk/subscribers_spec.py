import mock
import unittest

from mk import data_structures
from mk import subscribers


class MockRenderer(object):
    _implementation = {}

    def implementation(self):
        return self._implementation


class SubscribersTestCase(unittest.TestCase):
    def test_get_layout_adds_layout_to_event_data(self):
        event = data_structures.AttributeDict(
            request=data_structures.AttributeDict(
                registry=data_structures.AttributeDict(settings={})
            ),
        )

        renderer = MockRenderer()

        with mock.patch('pyramid.renderers.get_renderer') as patch:
            patch.return_value = renderer
            subscribers.get_layout(event)

        self.assertIs(event.get('layout'), renderer._implementation)
