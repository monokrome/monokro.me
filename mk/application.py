from pyramid.config import Configurator


def is_ignored_module(module_name):
    return module_name.split('.')[-1].endswith('_spec')


def main(global_configuration, **settings):
    configurator = Configurator(
        root_factory='mk.resources.RootResource',
        settings=settings,
    )

    configurator.include('pyramid_chameleon')
    configurator.include('opbeat_pyramid')

    configurator.scan(ignore=is_ignored_module)

    return configurator.make_wsgi_app()
