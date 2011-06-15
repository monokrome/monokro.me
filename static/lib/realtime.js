define(['/socket.io/socket.io.js'], function define_realtime (sio, msg) {

    var socket = new io.Socket(),
        message_handlers = {}, // Other modules can add these arbitrarily.
        socket_handlers = {
            'connect': function on_connect () { },

            'message': function on_message (message) {
                if (typeof message_handlers[message.type] != 'undefined')
                    message_handlers[message.type].apply(socket, [message]);
            },

            'disconnect': function on_disconnect () { }
        };

    // Set up any socket handlers required by this application
    for (handler_name in socket_handlers)
    {
        socket.on(handler_name, socket_handlers[handler_name]);
    }

    socket.connect();

    return {
        'socket': socket,
        'handlers': message_handlers
    };

});
