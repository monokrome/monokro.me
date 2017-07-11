from aiohttp import web
from aiohttp import web_request

from mk import routing


@routing.view('/')
async def index(request: web_request.Request) -> web.Response:
    return web.Response(text='Hello, Bailey!')
