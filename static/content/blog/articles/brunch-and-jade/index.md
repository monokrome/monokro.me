---
title: Brunch & Jade
author: monokrome
date: 2013-06-01
template: blog/article.jade

---

For the last year or so, I've been using a great project called [brunch][br] to
manage the compilation of static files for my projects. This project provides a
pretty great process for developing static pages for single-page apps, but some
of the plugins aren't very well thought out.

In my opinion, the worst case of this was found in brunch's support for the
[Jade][jd] templating language. The big problem with the support for [Jade][jd]
is that two separate plugins are used to handle it's templates. One was made
for handling the case of static content, while a different plugin handles
dynamic templates for rendering in the browser. Both of these plugins
([static-jade-brunch][sjb] and [jade-brunch][jb]) share nearly the same exact
functionality, but they have to be installed separately to get full
functionality.

Not only do they share the same functionality, but having two plugins doing
the same job in a slightly different way means that they can't work together.
This causes issues a lot of the time. For instance, if I want to use both
plugins in the same project - I have to adopt some file naming convention
that makes this separation more simple. I could name my static files as
`index.static.jade` to let [jade-brunch][jb] know that my index should be
compiled statically, but then it's also compiled as a dynamic template by
the other plugin since the extension is still jade. I could adopt the idea
of using app/static/index.jade to prevent needing an unusual `static.jade`
extension - but I still run into the same problem with double compiles (and
therefore useless/garbage data in my app.js).

Not only are these issues present, but static-jade-brunch doesn't actually
build files into your `public` directory either. It throws the static files
into your `app/static` directory, which then causes brunch to realize that
there is a new static file and then finally throw that resulting file into
public. I've seen some weird issues with this behavior, which I can only
assume are race conditions between plugins like [auto-reload-brunch][arb]
reloading pages prior to the static file being throw into `public`.

There are better ways to solve these problems. So, I decided to spend a
couple hours to solve these problems instead of just complaining about how
things should be better. I created a project called [jaded-brunch][jdb]
that solves the problem of both static file creation and dynamic templates
in one project. On top of this, the project also avoids rendering redundant
code from static templates into your app.js files [as much as possible][557]
within [brunch][br]'s current limitations. In order to make sure that
plugins like [auto-reload-brunch][arb] still work, [jaded-brunch][jdb] will
properly create files in your `public` directory.

This solves every issue that Brunch allows me to solve from the original
two plugins within a single installable plugin, it still provides at least
as much flexibility as the original plugins, and I think that it turned
pretty well. If you're interested in trying it out, it should immediately
replace [json-brunch][jb] and [static-jade-brunch][sjb] upon installing.

You can install it with `npm` or just add it to your `package.json` file
like any other brunch plugin. If you aren't sure how to install brunch
plugins, read the `README.md` file from [the repository][jdb].


[br]: http://brunch.io "Brunch - HTML5 Application Assembler"
[jd]: http://jade-lang.com/ "Jade Template Engine"
[jb]: http://github.com/brunch/jade-brunch "Jade Plugin"
[jdb]: http://github.com/monokrome/jaded-brunch "Jaded Brunch Plugin"
[sjb]: https://github.com/ilkosta/static-jade-brunch "Static Jade Plugin"
[arb]: https://github.com/brunch/auto-reload-brunch "Auto Reloade Plugin"
[557]: https://github.com/brunch/brunch/issues/557 "Brunch Issue #557"