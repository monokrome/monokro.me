from pyramid import config


def is_ignored_module(module_name):
    return module_name.split('.')[-1].endswith('_spec')


def main(global_configuration, **settings):
    configurator = config.Configurator(
        root_factory='mk.resources.RootResource',
        settings=settings,
    )

    configurator.scan()

    return configurator.make_wsgi_app()
