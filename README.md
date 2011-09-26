About the project
=================

This project represents a basic frontend for me to use in order to
get CoffeeScript projects started relatively quickly. The default
configuration makes use of the following technologies, but switching
most things out is left to be a simple task:

- NodeJS
	* Coffee-Script
	* Express
	* Jade
- Modernizr.js
- Respond.js

Architecture
============

The architecture of this project is made in a way that allows a
fair amount of flexibility while still providing good productivity,
and keeping it easy to get started with your frontend. Here is a
simple overview of what decisions have been made, and why they
have been made.

Directory structure
-------------------

By default, static files are served from the following directory
structure.

    public/ *contains all static files*
        scripts/ *contains all client-side script files*
            development/ *contains unminified scripts useful for development*
            production/ *contains minified scripts for production*
        views/ *contains our views for both server and client*
    src/ *contains all server-side source code*
    	stylesheets/ *contains .styl files for preprocessing CSS using Stylus syntax*
    server.js *bootstarts coffee-script and requires ./src/app*
    package.json *describes package dependancies and other metadata*

Why are views shared between server & client?
---------------------------------------------

As web-based applications become more dynamic (yes, they will) it is important to
make sure that we are able to render views on both server and client.
Something that currently exists on the server may need to be on the client
some day - or vice versa.

There are many times where markup needs to exist on
both the client and server in order to provide graceful degradation. This allows
the server and client to share the same view in these cases, which result
in less changes as things get more complicated. With these reasons and many
others, it is best to keep your views in a shared location to avoid extra work - even if you don't expect that work.

This is a practice that is just part of good forward development. I figure at
this point - based on previous experience - that many people are sitting here
right now saying *but I don't want to give away my business logic*! I will
just add that if your business logic is in your views, you've got bigger
problems.

Why are development and production scripts in different directories?
--------------------------------------------------------------------

Using multiple directories allows us to use different scripts for whichever express environment that has been configured. Sharing scripts between
environments can be done easily via symlinks:

    ln -s ./development ./staging

Doing this allows us to provide consistent filenames in our views. Here is an
example in jade:

    script(src=script_url('respond'))

Now, if you've got the NODE_ENV environment variable set to *development*, this
will translate into:

    <script src=/scripts/development/respond.js></script>

However, if you provide the *production* environment - which is our default - then
the same code will generate:

    <script src=/scripts/production/respond.min.js></script>

You can change which files need the ".min" in their extension by changing the
production_environments variable in *src/helpers.coffee*.

How do I use Stylus to pre-process my CSS files?
-----------------------------------------------

This project is automatically set up to do CSS pre-processing with [Stylus](http://learnboost.github.com/stylus/ "Stylus").
To use this functionality, you can put your Stylus code in *src/stylesheets* and they will be rendered as CSS files into
public/stylesheets. For instance, you might set up your web application to request **/stylesheets/common.css** which would
be rendered using */src/stylesheets/common.styl* when it doesn't exist. Stylesheets are rendered upon every request when
the server is running in a development environment.
