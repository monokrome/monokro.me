import unittest

import zope.interface.verify

from mk import interfaces
from mk import resources


class RootResourceTestCase(unittest.TestCase):
    def test_root_resource_implements_root_endpoint(self):
        zope.interface.verify.verifyClass(
            interfaces.IRootEndpoint,
            resources.RootResource,
        )
