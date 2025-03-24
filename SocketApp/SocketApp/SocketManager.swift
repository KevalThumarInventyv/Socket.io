//
//  SocketManager.swift
//  SocketApp
//
//  Created by Keval Thumar on 24/03/25.
//

import Foundation
import SocketIO

class SocketManagerService {
    static let shared = SocketManagerService()

    private let manager: SocketManager
    private let socket: SocketIOClient
    var mySocketId: String = ""

    private init() {
        self.manager = SocketManager(
            socketURL: URL(string: "http://localhost:3000")!,
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
    
    func receiveMessage(completion: @escaping (String) -> Void){
        socket.on("receive-message") { data, ack in
            if let message = data.first as? String {
                print(message)
                completion(message)
            }
        }
    }
    
    
    func sendMessage(_ message:String , toSocketId socketId:String){
        
        socket.emit("message", [message, socketId])
    }


    func welcome(completion: @escaping (String) -> Void) {
        socket.on("welcome") { data, ack in
            if let message = data.first as? String {
                print(data)
                completion(message)
            }
        }
    }

    func disconnect() {
        print("Socket disconnected successfully with socket ID: \(mySocketId)")
        socket.disconnect()
    }
}
