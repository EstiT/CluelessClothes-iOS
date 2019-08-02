//
//  RoundedView.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-01.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit

//https://stackoverflow.com/questions/46713603/round-corners-uiview-in-swift-4
@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var borderColor: UIColor = UIColor(displayP3Red: 179/255.0, green: 54/255.0, blue: 97/255.0, alpha: 0.95) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 13.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
