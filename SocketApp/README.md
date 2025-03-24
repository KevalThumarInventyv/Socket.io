# SocketApp

## Description

SocketApp is an iOS application that uses Socket.IO for real-time communication. It connects to a Node.js Socket.IO server, sends messages, and receives responses dynamically.

## Features

- Connect to a WebSocket server.
- Display the assigned socket ID.
- Send messages to a specific socket or broadcast.
- Receive real-time messages.

## Usage

### Connect to Server

```swift
    static let shared = SocketManagerService()

    private let manager: SocketManager
    private let socket: SocketIOClient
    var mySocketId: String = ""

    private init() {
        self.manager = SocketManager(
            socketURL: URL(string: "Socket URL")!,
            config: [.log(false ), .compress])
        self.socket = manager.defaultSocket
    }

    func connect(completion: @escaping (String) -> Void) {
        socket.connect()
        
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket connected with ID: \(self.socket.sid ?? "unknown")")
            self.mySocketId = self.socket.sid ?? "unknown"
            
            // Call completion handler with the updated socket ID
            completion(self.mySocketId)
        }
    }
```

### Send Message

```swift
@IBAction func btnSend(_ sender: UIButton) {
    SocketManagerService.shared.sendMessage(textfieldMessage.text ?? "", toSocketId: textFieldRoomId.text ?? "")
    textfieldMessage.text = ""
    textFieldRoomId.text = ""
}
```

### Receive Messages

```swift
SocketManagerService.shared.receiveMessage { message in
    DispatchQueue.main.async {
        self.messageOut.text = message
    }
}
```
