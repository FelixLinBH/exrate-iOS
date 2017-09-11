//
//  ViewController.swift
//  Exrate
//
//  Created by Lin Bo Han on 2017/9/11.
//  Copyright © 2017年 Lin Bo Han. All rights reserved.
//

import UIKit
import SocketIO
let socket = SocketIOClient(socketURL: URL(string: "http://18.221.63.20:80")!, config: [.log(true), .compress])


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        socket.on(clientEvent: .error) { (data, error) in
            print(data)
            print(error)
        }
        socket.on("message") {data, ack in
            print(data[0])
//            if let cur = data[0] as? Double {
//                socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
//                    socket.emit("update", ["amount": cur + 2.50])
//                }
//                
//                ack.with("Got your currentAmount", "dude")
//            }
        }
        
        socket.on("event") {data, ack in
            print(data[0])
            //            if let cur = data[0] as? Double {
            //                socket.emitWithAck("canUpdate", cur).timingOut(after: 0) {data in
            //                    socket.emit("update", ["amount": cur + 2.50])
            //                }
            //
            //                ack.with("Got your currentAmount", "dude")
            //            }
        }
        
        socket.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

