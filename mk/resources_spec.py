import unittest

import zope.interface.verify

from mk import interfaces
from mk import resources


class RootResourceTestCase(unittest.TestCase):
    def test_base_resource_sets_request_on_self(self):
        request = {}
        resource = resources.BaseResource(request)
        self.assertIs(resource.request, request)

    def test_root_resource_implements_root_endpoint(self):
        zope.interface.verify.verifyClass(
            interfaces.IRootEndpoint,
            resources.RootResource,
        )
