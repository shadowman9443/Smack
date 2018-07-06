//
//  CircleImageView.swift
//  Smack
//
//  Created by aunogarafat on 7/6/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

   
    override func awakeFromNib() {
        setupView()
    }
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
}
