//
//  LoginVC.swift
//  Smack
//
//  Created by aunogarafat on 6/29/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountbtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    
    
    @IBAction func loginbtnPressed(_ sender: Any) {
        guard let email = usernameTxt.text , usernameTxt.text != "" else {return}
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {return}
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success{
                print("login success")
            }
        }
    }
    
    
}
