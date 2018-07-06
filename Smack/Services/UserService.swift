//
//  UserService.swift
//  Smack
//
//  Created by aunogarafat on 7/5/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import Foundation
class UserService {
    static let instance = UserService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String)  {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
        
        func setAvatarName() {
            self.avatarName = avatarName
        }
    }
    
}
