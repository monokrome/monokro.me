import builtins
import functools
import importlib
import sys
import typing

from aiohttp import web, web_request
import venusian

ViewHndlerType = typing.Callable[[web_request.Request], web.Response]
# Note; Is there a better way to do this?
PackageType = builtins.__class__

application_ref = None


def setup_route(
    application: web.Application,
    url_pattern: str,
    method: str,
    handle_via: ViewHndlerType
) -> ViewHndlerType:

    method_name = 'add_' + method.lower()
    add_via = getattr(application.router, method_name, None)

    if add_via is None:
        fprint(
            sys.stderr,
            f'{method} is not a supported method for {handle_via}',
        )

    add_via(url_pattern, handle_via)
    return setup_route


def view(url_pattern: str, *, method: str='GET') -> ViewHndlerType:
    return functools.partial(setup_route, application_ref, url_pattern, method)


def scan(
    package: typing.Union[PackageType, str],
    application: typing.Optional[web.Application] = None,
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
