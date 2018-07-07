//
//  ChannelVC.swift
//  Smack
//
//  Created by aunogarafat on 6/27/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var profileImage: CircleImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareforUnWind(segue : UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userdataDidchange), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
         checkLogin()
    }
    @IBAction func loginPresse(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    @objc func userdataDidchange(_ notif : Notification)  {
       checkLogin()
    }
    func checkLogin() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserService.instance.name, for: .normal)
            profileImage.image = UIImage(named: UserService.instance.avatarName)
            profileImage.backgroundColor = UserService.instance.returnColor(components: UserService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            profileImage.image = UIImage(named: "menuProfileIcon")
            profileImage.backgroundColor = UIColor.clear
        }
    }
    
}
