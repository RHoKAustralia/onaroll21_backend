/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

app.get('/', function (req, res) {
    res.sendFile('index.html', {root: __dirname});
});

io.on('connection', function (socket) {
    console.log('a user connected');
    socket.on('chatmessage',function(msg){
        console.log('message: '+msg);
        io.emit('chatmessage',msg);
    });
    socket.on('disconnect', function () {
        console.log('user disconnected');
    });
});

http.listen(3000, function () {
    console.log('listening on *:3000');
});
