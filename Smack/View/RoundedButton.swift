//
//  RoundedButton.swift
//  Smack
//
//  Created by aunogarafat on 7/4/18.
//  Copyright © 2018 aunogarafat. All rights reserved.
//

import Foundation
@IBDesignable
class RoundedButton : UIButton {
    
    @IBInspectable var cornerRadius:CGFloat = 3.0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    override func awakeFromNib() {
        self.setupView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView()  {
        self.layer.cornerRadius = cornerRadius
    }
}

