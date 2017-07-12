import os
import typing
import functools

ContextType = typing.Dict[str, typing.Any]
RendererType = typing.Callable[[typing.Optional[ContextType]], str]


TEMPLATES_DIRNAME = os.environ.get('TEMPLATES_DIRNAME', 'templates')
TEMPLATES_PATH = os.sep.join([os.path.dirname(__file__), TEMPLATES_DIRNAME])


def render(path: str, body: str,
           data: typing.Optional[ContextType]=None) -> str:

    if data is None:
        data = {}

    return body


async def load(*path_segments: typing.Tuple[str]) -> RendererType:
    path_segments = list(path_segments)
    path_segments.insert(0, TEMPLATES_PATH)
    path = os.sep.join(path_segments)

    with open(path, 'r') as f:
        return functools.partial(render, path, f.read())
