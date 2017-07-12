import functools
import os
import string
import typing

ContextType = typing.Dict[str, typing.Any]
RendererType = typing.Callable[[typing.Optional[ContextType]], str]

TEMPLATES_DIRNAME = os.environ.get('TEMPLATES_DIRNAME', 'templates')
TEMPLATES_PATH = os.sep.join([os.path.dirname(__file__), TEMPLATES_DIRNAME])


def render(path: str, body: str, data: ContextType=None) -> str:

    if data is None:
        data = {}

    return string.Template(body).safe_substitute(data)


async def load(*args: str) -> RendererType:
    path_segments = list(args)
    path_segments.insert(0, TEMPLATES_PATH)
    path = os.sep.join(path_segments)

    with open(path, 'r') as f:
        return functools.partial(render, path, f.read())
