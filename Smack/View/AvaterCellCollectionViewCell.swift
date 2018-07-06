//
//  AvaterCellCollectionViewCell.swift
//  Smack
//
//  Created by aunogarafat on 7/6/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit
enum AvatarType {
    case dark
    case light
}
class AvaterCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    override func awakeFromNib() {
        setUpView()
    }
    func configureCell(index: Int,type: AvatarType)  {
        if type == AvatarType.dark {
            avatarImage.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImage.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
    }
    func setUpView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
