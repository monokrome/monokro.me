from pyramid import view


@view.view_config(renderer='templates/static/home.pt')
def home(request, context):
    return {}
