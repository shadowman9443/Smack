//
//  AvaterCellCollectionViewCell.swift
//  Smack
//
//  Created by aunogarafat on 7/6/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class AvaterCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    override func awakeFromNib() {
        setUpView()
    }
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
