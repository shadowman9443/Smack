//
//  CreateChannelVC.swift
//  Smack
//
//  Created by aunogarafat on 7/18/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class CreateChannelVC: UIViewController {

    @IBOutlet weak var bgView: UIView!
    
    
    @IBOutlet weak var chnannelName: UITextField!
    
    
    @IBOutlet weak var channelDescription: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func crossBtnChannel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createChannelBTn(_ sender: Any) {
        guard let chnlName = chnannelName.text , chnannelName.text != "" else {return}
        guard let channelDes = channelDescription.text , channelDescription.text != "" else {return}
        if AuthService.instance.isLoggedIn {
            SocketService.instance.addChannel(channelName: chnlName, channelDescription: channelDes) { (success) in
                if success {
                     self.dismiss(animated: true, completion: nil)
                }
            }
            
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
        
    }
    func setupView()  {
        
        chnannelName.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedStringKey.foregroundColor: smackPuprlePlaceHolder ])
        
        channelDescription.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedStringKey.foregroundColor: smackPuprlePlaceHolder ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateChannelVC.closeTap))
        view.addGestureRecognizer(tap)
    }
    @objc func closeTap()  {
       dismiss(animated: true, completion: nil)
    }
}
