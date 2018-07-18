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
    
    func findAllChannel(completion :@escaping CompletionHandler)  {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseData { (response) in
            if response.result.error == nil {
                
                guard let data = response.data else {return}
                
                do{
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                    print(self.channels)
                    completion(true)
                }catch let error {
                    debugPrint(error as Any)
                }
               
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
}
