var github = new (require('github').GitHubApi)(true),
    repo_api = github.getRepoApi(),

    repo_categories = {
        'django-authorized-comments': 'Python',
        'django-news': 'Python',
        'django-snippets': 'Python',
        'djynamite': 'Python',
        'monodjango': 'Python',

        'jquery-particles': 'JavaScript',
        'mappy': 'JavaScript',

        // GitHub thinks that this is C. Why?
        'openal-source': 'C++'
    },

    // Projects that I find aren't interesting.
    ignored_projects = [
        'quikee',
        'configuration',
        'monolo',
        'monokro.me-old',
        'mappy',
        'monodjango',
        'djynamite',
        'monokro.me',
        'django-authorized-comments',
        'cms.monokro.me'
    ];

module.exports = {
    get: function get_projects (callback) {
        repo_api.getUserRepos('monokrome', function get_repos (err, repos) {
            if (err) throw err;

            var projects = {},
                repo_index, repo;

            for (repo_index in repos)
            {
                var next_project = {};

                repo = repos[repo_index];

                // Verify that we have some category to use.
                if (typeof repo.language == 'undefined' || typeof repo_categories[repo.name] != 'undefined')
                {
                    if (typeof repo_categories[repo.name] != 'undefined')
                        repo.language = repo_categories[repo.name];
                    else
                        continue;
                }

                if (repo.fork)
                    continue;

                if (ignored_projects.indexOf(repo.name) != -1)
                    continue;

                if (typeof projects[repo.language] == 'undefined')
                    projects[repo.language] = [];

                projects[repo.language].push(repo);
            }

            callback(projects);
        });
    }
}
