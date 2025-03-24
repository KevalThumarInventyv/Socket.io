# Socket.IO Chat Server

This project is a **real-time chat server** built using **Node.js, Express, and Socket.IO**. It enables real-time communication between connected clients.

## Features

- Handles **user connections and disconnections**.
- Broadcasts a **welcome message** when a user joins.
- Supports **sending messages to specific rooms or all users**.
- Allows **CORS** for cross-origin requests.

## Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/your-repo/socket-server.git
    cd socket-server
    ```

2. Install dependencies:

    ```sh
    npm install
    ```

3. Start the server:

    ```sh
    node index.js
    ```

## Usage

### **Connect to the Server**

Clients should connect using Socket.IO:

```javascript
const socket = io('http://localhost:3000');
```

### **Receiving Welcome Messages**

```javascript
socket.on('welcome', (message) => {
    console.log(message);
});
```

### **Sending Messages**

```javascript
socket.emit('message', ['Hello, world!', 'room123']);
```

### **Receiving Messages**

```javascript
socket.on('receive-message', (message) => {
    console.log('New message:', message);
});
```