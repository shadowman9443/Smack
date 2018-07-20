//
//  ProfileVC.swift
//  Smack
//
//  Created by aunogarafat on 7/7/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    //out let
    @IBOutlet weak var profileImage: CircleImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var backgroundView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()

        // Do any additional setup after loading the view.
    }
    func setUpView()  {
        print(UserService.instance.name)
        print(UserService.instance.email)
        print(UserService.instance.avatarName)
        print(UserService.instance.avatarColor)
        userName.text = UserService.instance.name
        userEmail.text = UserService.instance.email
        profileImage.image = UIImage(named: UserService.instance.avatarName)
        profileImage.backgroundColor = UserService.instance.returnUIColor(components: UserService.instance.avatarColor)
        
    }
    //button actions

    @IBAction func profileDismissPrsd(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logoutPrsd(_ sender: Any) {
        UserService.instance.loggedOutUser()
         NotificationCenter.default.post(Notification.init(name: NOTIF_USER_DATA_DID_CHANGE))
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
