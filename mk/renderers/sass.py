import sass
import os

from pyramid import interfaces

from zope import interface


@interface.implementer(interfaces.IRendererFactory)
class SASSRendererFactory(object):
    STYLES_CACHE = {}  # TODO: Maybe a MRU cached or something?

    def __init__(self, info):
        self.registry = info.registry

        self.template_path = os.path.join(
            os.path.dirname(info.package.__file__),
            info.name,
        )

    def _get_file_contents(self):
        with open(self.template_path, 'r') as resource:
            return resource.read()

    def __call__(self, value, system):
        file_contents = self.STYLES_CACHE.get(self.template_path, None)

        if not file_contents:
            file_contents = self._get_file_contents()

        if not self.registry.settings.get('pyramid.reload_templates'):
            self.STYLES_CACHE[self.template_path] = file_contents

        return sass.compile(string=file_contents)
