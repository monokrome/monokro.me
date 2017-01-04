from pyramid import events

from pyramid import interfaces
from pyramid import renderers


@events.subscriber(interfaces.IBeforeRender)
def get_layout(event):
    """ Insert layout into template context. """

    settings = event['request'].registry.settings
    layout_name = settings.get('mk.layout', 'standard')
    renderer = 'templates/layouts/' + layout_name + '.pt'
    event['layout'] = renderers.get_renderer(renderer).implementation()
