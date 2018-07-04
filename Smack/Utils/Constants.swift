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

//sugue
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let TO_UNWIND_CAHNNEL = "unwindtoChannel"

//login credential
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"
