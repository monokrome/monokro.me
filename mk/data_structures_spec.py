import unittest

from mk import data_structures


class AttributeDictTestSuite(unittest.TestCase):
    def test_keys_can_be_accessed_as_keys(self):
        obj = data_structures.AttributeDict()
        obj['key'] = 'value'
        self.assertEquals(obj['key'], 'value')

    def test_attributes_can_be_accessed_as_attributes(self):
        obj = data_structures.AttributeDict()
        obj.key = 'value'
        self.assertEquals(obj.key, 'value')

    def test_keys_can_be_accessed_as_attributes(self):
        obj = data_structures.AttributeDict()
        obj['key'] = 'value'
        self.assertEquals(obj.key, 'value')

    def test_attributes_can_be_accessed_as_keys(self):
        obj = data_structures.AttributeDict()
        obj.key = 'value'
        self.assertEquals(obj['key'], 'value')
