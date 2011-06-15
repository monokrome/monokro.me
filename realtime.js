var io = require('socket.io'),
    winston = require('winston');

function setup_realtime (server)
{
    var socket = io.listen(server);
    socket.on('connection', function connection_handler (client) {
        client.on('message', function message_handler (message) {
        });
    
        client.on('disconnect', function message_handler (message) {
        });
    });
}

module.exports = setup_realtime;
