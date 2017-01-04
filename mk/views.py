from pyramid.view import view_config


@view_config(renderer='json')
def home(request, context):
    return {}
