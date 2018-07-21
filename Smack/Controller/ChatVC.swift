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
    
    @IBOutlet weak var chennelnamlebel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
          NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userdataDidchange), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected), name: NOTIF_CHANNELS_SELECTED, object: nil)
        if AuthService.instance.isLoggedIn {
            AuthService.instance.getUserByEmail(completion: { (success) in
                if success{
                    NotificationCenter.default.post(Notification.init(name: NOTIF_USER_DATA_DID_CHANGE))
                   
                   
                }
            })
        }
       
       
    }
    @objc func userdataDidchange(_ notif : Notification)  {
        if AuthService.instance.isLoggedIn {
            //get channel
            onLoginMessage()
        }else{
            chennelnamlebel.text = "Please log in"
        }
    }
    @objc func channelSelected(_ notif : Notification)  {
       updatewithCahnnel()
    }
    func onLoginMessage()  {
        MessageService.instance.findAllChannel { (success) in
            if success{
               //do stuff with channel
                
                
            }
        }
    }
    func updatewithCahnnel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chennelnamlebel.text = "#\(channelName)"
    }

   

}
