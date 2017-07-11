from aiohttp import web

import mk
from mk import routing


def get_application() -> web.Application:
    return routing.scan(mk)
