from zope import interface

from . import interfaces


class BaseResource(dict):
    def __init__(self, request, *args, **kwargs):
        super(BaseResource, self).__init__(*args, **kwargs)

        self.request = request


@interface.implementer(interfaces.IRootEndpoint)
class RootResource(BaseResource):
    pass
