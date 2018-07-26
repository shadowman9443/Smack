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
    func addMessage(messageBody: String , userId: String , channelid : String , completion: @escaping CompletionHandler)  {
        let user = UserService.instance
        socket.emit("newMessage", messageBody, userId , channelid, user.name , user.avatarName, user.avatarColor)
        completion(true)
    }
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void)  {
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelID = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelID, userAvater: userAvatar, userAvaterColor: userAvatarColor, id: id, timeStamp: timeStamp )
            print(newMessage)
            completion(newMessage)
//            if channelID == MessageService.instance.selectedChannel?.id &&  AuthService.instance.isLoggedIn {
//
//
//                MessageService.instance.messages.append(newMessage)
//                completion(true)
//            }else {
//                completion(false)
//            }
        }
    }
    
    func getTypingUser(_ completionHandler: @escaping ([String: String]) -> Void) {
        //Do something
        socket.on("userTypingUpdate") { (dataArray, acknowledged) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers)
        }
    }
}














