//
//  MessageService.swift
//  Smack
//
//  Created by aunogarafat on 7/12/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel :  Channel?
    
    func findAllChannel(completion :@escaping CompletionHandler)  {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseData { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                        print(self.channels[0].channelTitle)
                         NotificationCenter.default.post(Notification.init(name: NOTIF_CHANNELS_LOADED))
                        completion(true)
                    }
                } catch {
                    print(error)
                }
               
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findAllmessage(channelId: String, completion :@escaping CompletionHandler) {
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseData { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let userName = item["userName"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let messageBody = item["messageBody"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvater: userAvatar, userAvaterColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(message)
                        }
                        print(self.messages)
                        completion(true)
                    }
                } catch {
                    print(error)
                }
                
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func clearMessages()  {
        messages.removeAll()
    }
    
    
    
    func clearChannel()  {
        channels.removeAll()
    }
    
}
