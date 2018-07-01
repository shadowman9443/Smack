//
//  ChannelVC.swift
//  Smack
//
//  Created by aunogarafat on 6/27/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareforUnWind(segue : UIStoryboardSegue){
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

    @IBAction func loginPresse(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
}
