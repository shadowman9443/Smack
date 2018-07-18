//
//  Constants.swift
//  Smack
//
//  Created by aunogarafat on 6/29/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import Foundation
typealias CompletionHandler = (_ Success: Bool) -> ()

//url constant
let BASE_URL = "https://chattychatmontu.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_ADD_USER = "\(BASE_URL)user/add"
let GET_USER_BY_EMAIL = "\(BASE_URL)user/byEmail"
let URL_GET_CHANNELS =  "\(BASE_URL)channel/"

//color

let smackPuprlePlaceHolder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.6637681935)

//notification instance
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")


//sugue
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let TO_UNWIND_CAHNNEL = "unwindtoChannel"
let TO_AVATER_PICKER  = "toAvaterPicker"
//login credential
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//header

let HEADER = [
    "Content-Type": "application/json; charset=utf-8"
]

let BEARER_HEADER = [
    "Authorization":"Bearer \(AuthService.instance.authToke)",
    "Content-Type": "application/json; charset=utf-8"
    
]
