define(['/socket.io/socket.io.js'], function define_realtime () {
    var socket = new io.Socket();

    socket.on('connect', function connection_handler (client) {
    });

    socket.on('message', function message_handler (message) {
    });

    socket.on('disconnect', function disconnect_handler () {
    });

    socket.connect();
});
