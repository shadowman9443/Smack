//
//  AuthService.swift
//  Smack
//
//  Created by aunogarafat on 7/2/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService{
    static let instance = AuthService()
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToke: String {
        get {
            return defaults.value(forKey: TOKEN_KEY)as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL)as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String , completion: @escaping CompletionHandler){
        let loawerCaseEmail = email.lowercased()
        
        let header = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        let body : [String: Any] = [
            "email": loawerCaseEmail,
            "password":password
        ]
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String , completion: @escaping CompletionHandler){
        let loawerCaseEmail = email.lowercased()
        
       
        let body : [String: Any] = [
            "email": loawerCaseEmail,
            "password":password
        ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
//                if let json = response.result.value as? Dictionary<String , Any>{
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToke = token
//                    }
//                }
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    
                    self.userEmail = json["user"].string!
                    self.authToke = json["token"].string!
                } catch {
                     print(error)
                }
                
                self.isLoggedIn = true
               
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
       
    }
    func createUser(name: String, email: String, avatarName: String, avatarColor: String , completion: @escaping CompletionHandler){
        let loawerCaseEmail = email.lowercased()
        
        
        let body : [String: Any] = [
            "name":name,
            "email": loawerCaseEmail,
            "avatarName":avatarName,
            "avatarColor": avatarColor
        ]
        
        let header = [
            "Authorization": "Bearer \(AuthService.instance.authToke)",
            "Content-Type": "application/json; charset=utf-8"
            
        ]
        Alamofire.request(URL_ADD_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseString { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func getUserByEmail(completion: @escaping CompletionHandler)  {
        Alamofire.request("\(GET_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseString { (response) in
            if response.result.error == nil {
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
           }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func setUserInfo(data : Data){
            do {
                let json = try JSON(data: data)
                
                let id = json["_id"].stringValue
                let color = json["avatarColor"].stringValue
                let avatarName = json["avatarName"].stringValue
                let email = json["email"].stringValue
                let name = json["name"].stringValue
                UserService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                
            } catch {
                print(error)
            }
    }

}
    
    
    
    
    
    
    
    

