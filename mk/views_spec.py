import unittest

from mk import views


class HomeViewTestCase(unittest.TestCase):
    def test_returns_dictionary(self):
        self.assertEqual(views.home(None, None), {})
