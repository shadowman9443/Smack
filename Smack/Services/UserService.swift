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
        
        
    }
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func  returnColor(components: String) -> UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[],")
        let comma = CharacterSet(charactersIn: ",")
        
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b ,a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        let deafaultColor = UIColor.lightGray
        
        guard r != nil else { return deafaultColor }
        guard g != nil else { return deafaultColor }
        guard b != nil else { return deafaultColor }
        guard a != nil else { return deafaultColor }
        
        let rFloat = CGFloat((r?.doubleValue)!)
        let gFloat = CGFloat((g?.doubleValue)!)
        let bFloat = CGFloat((b?.doubleValue)!)
        let aFloat = CGFloat((a?.doubleValue)!)
        
        let newUIColor = UIColor(displayP3Red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)
        return newUIColor
    }
    func loggedOutUser(){
        id = ""
        avatarColor = ""
        avatarName = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToke = ""
    }
}
