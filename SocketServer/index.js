import express from 'express';
import { createServer } from 'http';
import { Server } from 'socket.io';

const app = express();
const server = createServer(app);
const io = new Server(server , {
    cors: {
        origin: "*",
        methods: ["GET", "POST"],
        credentials: true
    }
});

app.get('/', (req, res) => {
  res.send('Hello World');
});

io.on('connection', (socket) => {
    console.log('a user connected');
    console.log('socket.id', socket.id);

    // io.emit('welcome', `Welcome from server with socket id: ${socket.id}`); // send to all
    socket.broadcast.emit('welcome', `Welcome from server with socket id: ${socket.id}`); // send to all except sender
    // socket.emit('welcome', `Welcome from server with socket id: ${socket.id}`); // send to sender

    socket.on('message', (data) => {
        console.log
        (data);

        const [message, roomID] = data;
        console.log('message', message);
        console.log('roomID', roomID);


        if(roomID !== ""){
            let roomsIds = roomID.split(",");
            console.log(roomsIds);
            io.to(roomsIds).emit('receive-message', message)
        }
        else{
            socket.broadcast.emit('receive-message', message)
        }
        // socket.broadcast.emit('receive-message', msg + "broadcast");
        // io.emit('receive-message', msg + "io");
        // socket.emit('receive-message', msg + "socket");


    }); 

    socket.on('disconnect', () => {
        console.log('user disconnected');
    });

})


const PORT = 3000;

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

