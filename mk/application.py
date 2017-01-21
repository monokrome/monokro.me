from pyramid import config


def is_ignored_module(module_name):
    return module_name.split('.')[-1].endswith('_spec')


def main(global_configuration, **settings):
    configurator = config.Configurator(
        root_factory='mk.resources.RootResource',
        settings=settings,
    )

    configurator.add_renderer(
        name='.scss',
        factory='mk.renderers.sass.SASSRendererFactory',
    )

    configurator.add_renderer(
        name='.sass',
        factory='mk.renderers.sass.SASSRendererFactory',
    )

    configurator.scan()
    return configurator.make_wsgi_app()
