(function () {
    var configuration = {
        baseUrl: '/lib/',

        priority: [
            'jquery-base', // This package gets around an issue in RequireJS.
        ],

        ready: function require_bad_modules () {
            require(dependancies);
        }
    },

    dependancies = ['application'];

    require(configuration);
})();
