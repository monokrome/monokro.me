var express = require('express'),
    server = express.createServer(),
    views = require('./views'),
    realtime = require('./realtime');

server.use(express.static(__dirname + '/static'));
server.use(express.errorHandler({ dumpExceptions: false, showStack: false }));

server.set('views', __dirname + '/static/templates');

views(server);

server.listen(8000);
realtime(server);
