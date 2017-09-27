//
//  ViewController.swift
//  Exrate
//
//  Created by Lin Bo Han on 2017/9/11.
//  Copyright © 2017年 Lin Bo Han. All rights reserved.
//

import UIKit
import SocketIO
import LZCompression
let socket = SocketIOClient(socketURL: URL(string: "https://www.exrate.info")!, config: [.log(false), .compress])


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        

        socket.on("message") {data, ack in
            if let dictionary = data[0] as? [String: Any] {

                
                for (key, value) in dictionary {
                    // access all key / value pairs in dictionary
                    print(key)
                    let decompressValue = (value as! String)
                    print(decompressValue.decompressLZFromUTF16())
                    
                }
                
            }
        }
        
        socket.on("event") {data, ack in
            print(data[0])
            if let action = data[0] as? String {
                switch action {
                    case "end":
                        socket.disconnect()
                    default:
                        print("nothing")
                }
                
            }
            
        }
        
        socket.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

