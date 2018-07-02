//
//  AuthService.swift
//  Smack
//
//  Created by aunogarafat on 7/2/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import Foundation

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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
