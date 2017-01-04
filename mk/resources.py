from zope import interface
from . import interfaces


class BaseResource(dict):
    def __init__(self, request):
        pass


@interface.implementer(interfaces.RootEndpoint)
class RootResource(BaseResource):
    pass
