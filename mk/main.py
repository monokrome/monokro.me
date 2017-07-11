from aiohttp import web

from mk import routing


def get_application() -> web.Application:
    application = web.Application()
    routing.setup(application)
    return application
