import functools
import importlib
import sys
import types
import typing

from aiohttp import web
from aiohttp import web_request
import venusian

ViewHandlerType = typing.Callable[[web_request.Request], web.Response]

application_ref = None


def setup_route(application: web.Application,
                url_pattern: str,
                method: str,
                handle_via: ViewHandlerType) -> ViewHandlerType:

    method_name = 'add_' + method.lower()
    add_via = getattr(application.router, method_name, None)

    if add_via is None:
        error_message = '{} is not a supported method for {}'
        sys.stderr.write(error_message.format(method, handle_via))

    add_via(url_pattern, handle_via)
    return handle_via


def view(url_pattern: str, *, method: str='GET') -> ViewHandlerType:
    return functools.partial(setup_route, application_ref, url_pattern, method)


def scan(
        package: typing.Union[types.ModuleType, str],
        application: typing.Optional[web.Application]=None,
) -> web.Application:

    # TODO: Deprecate this silly hack
    global application_ref

    if isinstance(package, str):
        package = importlib.import_module(package)

    if application is None:
        application = web.Application()

    # Hack to get application into setup_route
    application_ref = application
    scanner = venusian.Scanner()
    scanner.scan(package)
    application_ref = None

    return application
