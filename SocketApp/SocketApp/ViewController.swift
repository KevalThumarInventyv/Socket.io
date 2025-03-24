//
//  ViewController.swift
//  SocketApp
//
//  Created by Keval Thumar on 24/03/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        SocketManagerService.shared.connect { socketId in
            DispatchQueue.main.async {
                self.mySocketId.text = "My Socket Id is : \(socketId)"
            }
        }
//        SocketManagerService.shared.welcome(completion: { message in
//            DispatchQueue.main.async {
//                self.messageOut.text = message
//
//            }
//        })
        SocketManagerService.shared.receiveMessage(completion: { message in
            DispatchQueue.main.async {
                self.messageOut.text = message
            }
        })

    }
    @IBOutlet weak var mySocketId: UILabel!

    @IBOutlet weak var messageOut: UILabel!

    @IBOutlet weak var textFieldRoomId: UITextField!
    @IBOutlet weak var textfieldMessage: UITextField!
    @IBAction func btnSend(_ sender: UIButton) {
        SocketManagerService.shared.sendMessage(textfieldMessage.text ?? "", toSocketId: textFieldRoomId.text ?? "")
        textfieldMessage.text = ""
        textFieldRoomId.text = ""
    }
}
