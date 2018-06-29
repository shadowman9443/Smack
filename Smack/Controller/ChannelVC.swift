//
//  ChannelVC.swift
//  Smack
//
//  Created by aunogarafat on 6/27/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

    
}
