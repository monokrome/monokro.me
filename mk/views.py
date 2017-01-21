from pyramid import view

from mk import services


@view.view_config(name='post', renderer='templates/post/item.pt')
def home(context, request):
    wordpress_site = request.registry.settings.get('wordpress.site')
    wordpress = services.Wordpress(wordpress_site)
    return {'items': wordpress.get_posts()}
