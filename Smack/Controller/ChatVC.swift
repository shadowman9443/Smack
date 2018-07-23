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
    
    @IBOutlet weak var msgText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
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
                if MessageService.instance.channels.count > 0{
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updatewithCahnnel()
                }else{
                     self.chennelnamlebel.text = "No channels yet!"
                }
                
                
            }
        }
    }
    func updatewithCahnnel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chennelnamlebel.text = "#\(channelName)"
        getMessagesFromChannel()
    }
    func getMessagesFromChannel() {
        guard let chId = MessageService.instance.selectedChannel?.id  else {
            return
        }
        
        MessageService.instance.findAllmessage(channelId: chId) { (success) in
            
        }
    }
    @objc func handleTap()  {
        view.endEditing(true)
    }
    @IBAction func sendBtnClicked(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            guard let chId = MessageService.instance.selectedChannel?.id  else {
                return
            }
            guard let msg = msgText.text , msgText.text != "" else {return}
            
            SocketService.instance.addMessage(messageBody: msg, userId: UserService.instance.id, channelid: chId) { (success) in
                if success {
                    self.msgText.text = ""
                    self.msgText.resignFirstResponder()
                }
            }
        }
    }
    
}
