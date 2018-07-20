//
//  ChannelVC.swift
//  Smack
//
//  Created by aunogarafat on 6/27/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var profileImage: CircleImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func prepareforUnWind(segue : UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userdataDidchange), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
         checkLogin()
    }
    @IBAction func loginPresse(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            //show profile page
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
           performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
    @objc func userdataDidchange(_ notif : Notification)  {
       checkLogin()
    }
    
    
    @IBAction func addChannelBtn(_ sender: Any) {
        let addChannel = CreateChannelVC()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }
    
    func checkLogin() {
        if AuthService.instance.isLoggedIn {
            print("\(UserService.instance.name)")
            print("\(UserService.instance.avatarName)")
            print("\(UserService.instance.avatarColor)")
            loginBtn.setTitle(UserService.instance.name, for: .normal)
            profileImage.image = UIImage(named: UserService.instance.avatarName)
            profileImage.backgroundColor = UserService.instance.returnUIColor(components: UserService.instance.avatarColor)
            MessageService.instance.findAllChannel { (success) in
                
                if success{
                    
                    print("exec")
                }
            }
        } else {
            loginBtn.setTitle("Login", for: .normal)
            profileImage.image = UIImage(named: "menuProfileIcon")
            profileImage.backgroundColor = UIColor.clear
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let  channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
}
