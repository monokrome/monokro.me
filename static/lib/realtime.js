define(['/socket.io/socket.io.js'], function define_realtime () {
    var socket = new io.Socket(),
        socket_handlers = {
            'connect': function on_connect () { },
            'message': function on_message (message) { },
            'disconnect': function on_disconnect () { }
        };

    // Set up any socket handlers required by this application
    for (handler_name in socket_handlers)
    {
        socket.on(handler_name, socket_handlers[handler_name]);
    }

    socket.connect();

    return { 'socket': socket };
});
