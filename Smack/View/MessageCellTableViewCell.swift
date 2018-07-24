//
//  MessageCellTableViewCell.swift
//  Smack
//
//  Created by aunogarafat on 7/24/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {
    //outlet
    @IBOutlet weak var userImg: CircleImageView!
    
    @IBOutlet weak var usernameTxt: UILabel!
    
    @IBOutlet weak var sendtimeTxt: UILabel!
    
    @IBOutlet weak var msgText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configurecell(message: Message)  {
        usernameTxt.text = message.userName
        msgText.text = message.message
        userImg.image = UIImage(named: message.userAvater)
        userImg.backgroundColor = UserService.instance.returnUIColor(components: message.userAvaterColor)
        
    }
}
