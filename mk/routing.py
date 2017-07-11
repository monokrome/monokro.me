import typing

from aiohttp import web
from aiohttp import web_request

from mk import views

ViewHandler = typing.Callable[[web_request.Request], web.Response]


def add_view(url_pattern: str, handle_via: ViewHandler):
    return application.router.add_get(url_pattern, handle_via)


def setup(application: 'aiohttp.web.Application'):
    """ TODO: Scanning / Decorators """

    return application.router.add_get('/', views.index)
