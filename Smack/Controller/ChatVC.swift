//
//  ChatVC.swift
//  Smack
//
//  Created by aunogarafat on 6/27/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    
    //OUTLETS
    
    @IBOutlet weak var menuBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.getUserByEmail(completion: { (success) in
                if success{
                    NotificationCenter.default.post(Notification.init(name: NOTIF_USER_DATA_DID_CHANGE))
                   
                }
            })
        }
    }

   

}
