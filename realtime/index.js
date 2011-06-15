var io = require('socket.io'),
    message_handlers = require('./messages'),
    winston = require('winston');

function setup_realtime (server)
{
    var socket = io.listen(server);

    socket.on('connection', function connection_handler (client) {
        client.on('message', function message_handler (message) {
            if (!message || !message.type) return;

            if (typeof message_handlers[message.type] != 'undefined')
            {
                message_handlers[message.type].apply(socket, [message]);
            }
        });
    
        client.on('disconnect', function message_handler (message) {
        });
    });
}

module.exports = setup_realtime;
