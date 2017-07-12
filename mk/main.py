from aiohttp import web

from mk import routing


def get_application() -> web.Application:
    return routing.scan('mk')
