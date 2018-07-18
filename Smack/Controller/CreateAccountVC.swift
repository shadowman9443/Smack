//
//  CreateAccountVC.swift
//  Smack
//
//  Created by aunogarafat on 7/1/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    //outlets
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor : UIColor?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserService.instance.avatarName != "" {
            userImage.image = UIImage(named: UserService.instance.avatarName)
            avatarName = UserService.instance.avatarName
            print("\(avatarName)")
            if avatarName.contains("light") && bgColor == nil {
                userImage.backgroundColor = UIColor.lightGray
            }
        }
    }
    @IBAction func exitCreateAcountBtnPresed(_ sender: Any) {
        performSegue(withIdentifier: TO_UNWIND_CAHNNEL, sender: nil)
    }
    
    @IBAction func chooseAvtrPrsd(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATER_PICKER, sender: nil)
    }
    @IBAction func pickBGColoredprsd(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(displayP3Red: r, green: b, blue: g, alpha: 1)
        avatarColor = "[\(r),\(b),\(g),1]"
        UIView.animate(withDuration: 0.2){
            self.userImage.backgroundColor = self.bgColor
        }
        
    }
    @IBAction func createAccount(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        guard let username = usernameTxt.text , usernameTxt.text != "" else {return}
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {return}
        print(UserService.instance.name,UserService.instance.avatarColor)
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success{
                AuthService.instance.loginUser(email: email, password: pass) { (success) in
                    if success{
                        print("login success")
                        AuthService.instance.createUser(name: username, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print("createUser success")
                            print(UserService.instance.name,UserService.instance.avatarColor)
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                
                                
                                NotificationCenter.default.post(Notification.init(name: NOTIF_USER_DATA_DID_CHANGE))
                                self.performSegue(withIdentifier: TO_UNWIND_CAHNNEL, sender: nil)
                                
                            }
                        })
                        
                    }
                }
                    
                
                }
            }
        }
        func setupView()  {
            spinner.isHidden = true
            usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPuprlePlaceHolder ])
            emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPuprlePlaceHolder ])
            
            passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPuprlePlaceHolder ])
            let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
            view.addGestureRecognizer(tap)
        }
        @objc func handleTap()  {
            view.endEditing(true)
        }
        
}
