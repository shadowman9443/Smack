//
//  CreateAccountVC.swift
//  Smack
//
//  Created by aunogarafat on 7/1/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func exitCreateAcountBtnPresed(_ sender: Any) {
          performSegue(withIdentifier: TO_UNWIND_CAHNNEL, sender: nil)
    }
    

}
