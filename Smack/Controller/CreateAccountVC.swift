//
//  CreateAccountVC.swift
//  Smack
//
//  Created by aunogarafat on 7/1/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func exitCreateAcountBtnPresed(_ sender: Any) {
          performSegue(withIdentifier: TO_UNWIND_CAHNNEL, sender: nil)
    }
    
    @IBAction func chooseAvtrPrsd(_ sender: Any) {
        
    }
    @IBAction func pickBGColoredprsd(_ sender: Any) {
        
    }
    @IBAction func createAccount(_ sender: Any) {
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success{
                print("register success")
            }
        }
    }
    
}
