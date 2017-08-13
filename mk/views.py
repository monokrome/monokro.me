from aiohttp import web
from aiohttp import web_request

from mk import routing
from mk import templates


@routing.view('/')
async def index(request: web_request.Request) -> web.Response:
    template = await templates.load('index.html')

    content = template({
        'url': request.url,
    })

    return web.Response(text=content, content_type='text/html')
