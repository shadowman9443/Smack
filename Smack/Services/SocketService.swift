//
//  SocketService.swift
//  Smack
//
//  Created by aunogarafat on 7/19/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import Foundation
import SocketIO

class SocketService : NSObject {
    
    static let instance = SocketService()
    //var socket:SocketIOClient! = nil
    
    override init() {
        super.init()
    }
    
    
    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])
    var socket:SocketIOClient{
        get {
            return manager.defaultSocket
        }
    }
    
    func establishedConnection(){
       socket.connect()
    }
    
    func closeConnection()  {
      socket.disconnect()
    }
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler)  {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    func getChannel( completion: @escaping CompletionHandler)  {
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
           
            
            
            
            let newChannel =  Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelID)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
}














