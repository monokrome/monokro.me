from pyramid import events

from pyramid import interfaces
from pyramid import renderers


def _get_layout_renderer(extension, event):
    settings = event['request'].registry.settings
    layout_name = settings.get('mk.layout', 'standard')
    renderer_path = 'templates/layouts/' + layout_name + '.' + extension
    return renderers.get_renderer(renderer_path)


@events.subscriber(interfaces.IBeforeRender)
def get_layout(event):
    """ Insert layout into template context. """

    event['layout'] = _get_layout_renderer('pt', event).implementation()


@events.subscriber(interfaces.IBeforeRender)
def get_stylesheet(event):
    """ Insert stylesheet into template context. """

    value = event.rendering_val
    event['stylesheet'] = _get_layout_renderer('scss', event)(value, event)
