//
//  ChatVC.swift
//  Smack
//
//  Created by aunogarafat on 6/27/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class ChatVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    //variable
    var isTyping : Bool = false
    
    //OUTLETS
    
    @IBOutlet weak var typingText: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIButton!
    
    @IBOutlet weak var chennelnamlebel: UILabel!
    
    @IBOutlet weak var msgText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        sendButton.isHidden = true
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
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
        SocketService.instance.getChatMessage { (newMessage) in
                if newMessage.channelId == MessageService.instance.selectedChannel?.id &&  AuthService.instance.isLoggedIn {
                    MessageService.instance.messages.append(newMessage)
                    self.tableView.reloadData()
                    if MessageService.instance.messages.count > 0 {
                        let endIndex = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
                        self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                    }
                    
                }else {
                    
                }
        }
        SocketService.instance.getTypingUser { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            var names = ""
            var numberofTypers = 0
            for (typingUser, channel) in typingUsers {
                if typingUser != UserService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    }else {
                        names = "\(names), \(typingUser)"
                    }
                    numberofTypers += 1
                }
            }
            if numberofTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberofTypers > 1 {
                    verb = "are"
                }
                self.typingText.text = "\(names) \(verb) typing message"
            }else {
                self.typingText.text = ""
            }
        }
//        SocketService.instance.getChatMessage { (success) in
//            if success {
//                self.tableView.reloadData()
//                if MessageService.instance.messages.count > 0 {
//                    let endIndex = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
//                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
//                }
//
//            }
//        }
       
       
    }
    @objc func userdataDidchange(_ notif : Notification)  {
        if AuthService.instance.isLoggedIn {
            //get channel
            onLoginMessage()
        }else{
            chennelnamlebel.text = "Please log in"
            tableView.reloadData()
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
            if success {
                self.tableView.reloadData()
            }
            
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
                    
                    //
//                    SocketService.instance.getChatMessage { (success) in
//                        if success {
//                            self.tableView.reloadData()
//                            if MessageService.instance.messages.count > 0 {
//                                let endIndex = IndexPath(row: MessageService.instance.messages.count-1, section: 0)
//                                self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
//                            }
//
//                        }
//                    }
                  // self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCellTableViewCell {
            let  message = MessageService.instance.messages[indexPath.row]
            cell.configurecell(message: message)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    @IBAction func messagTxtEditing(_ sender: Any) {
        guard let chId = MessageService.instance.selectedChannel?.id  else {
            return
        }
        if msgText.text == "" {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserService.instance.name,chId)
        }else {
            if isTyping == false {
                sendButton.isHidden = false
                SocketService.instance.socket.emit("startType", UserService.instance.name,chId)
            }
            isTyping = true
            
        }
//        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
//        if messageTxtBox.text == "" {
//            isTyping = false
//            sendBtn.isHidden = true
//            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
//        } else {
//            if isTyping == false {
//                sendBtn.isHidden = false
//                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
//            }
//            isTyping = true
//        }
    }
}

