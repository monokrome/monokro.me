from pyramid.view import view_config


@view_config(renderer='templates/home.pt')
def home(request, context):
    return {}
