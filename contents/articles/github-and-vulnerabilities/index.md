---
title: Github & Vulnerabilities
author: monokrome
date: 2013-06-02
template: article.jade
---

There's a new search on [GitHub][gh] which [has been floating around][lulz] for a few
days now. This specific search happens to have the neat effect that pretty much
all results are SQL injection vulnerabilities in many projects. This is - at
first look - a pretty funny way to creatively search [GitHub][gh].

However, let's look past the initial humurous reaction to the results here.
Whoever decided to search for this stumbled on a very interesting concept. I
think that it'd either be a neat service for [GitHub][gh] to add to their paid
product, or it is completely possible that someone might even experiment with
leveraging the [GitHub][gh] API to report potential vulnerabilities in projects
with a method much similar to how projects like [Travis][tci] leverage
[GitHub][gh] to work with your code.

I'd probably prefer the second option since [GitHub][gh] is notoriously
unstable.

[gh]: http://github.com "GitHub - Social Coding"
[tci]: http://travis-ci.org "Travis Continuous Integration"
[lulz]: http://goo.gl/PX5zP "Potential MySQL Injection Attacks"
