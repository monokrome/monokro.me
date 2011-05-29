var projects = require('./projects'),
    repo_list;

/**
 * Set up a local cache that is updated every five minutes, so that an increase
 * in traffic doesn't piss off GitHub... Albeit, I doubt that case will ever
 * occur.
 *
 * @TODO: Check if we can have GitHub send us updates instead.
 */
function finalize_project_update (repositories) {
    repo_list = repositories;
}

repo_list = finalize_project_update();

setInterval(function update_repositories () {
    projects.get(finalize_project_update)
}, 50000)

var views = {
    '/': function index_view (req, res) {
        var finalize = (function finalize (repositories) {
            finalize_project_update(repositories);

            res.render('index.jade', {
                project_categories: repositories
            });
        });

        if (typeof repo_list == 'undefined')
        {
            projects.get(finalize);
        }
        else
        {
            finalize(repo_list);
        }
    }
};

module.exports = (function setup (server)
{
    var expression, descriptor, method_index, method;

    for (expression in views)
    {
        descriptor = views[expression];

        if (typeof descriptor == 'function')
            descriptor = { handler: descriptor };

        if (typeof descriptor['methods'] == 'undefined')
            descriptor['methods'] = ['GET'];

        for (method_index in descriptor['methods'])
        {
            method = descriptor['methods'][method_index].toLowerCase();

            server[method](expression, descriptor['handler']);
        }
    }
});
