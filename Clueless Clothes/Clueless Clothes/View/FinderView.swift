//
//  FinderView.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2020-07-24.
//  Copyright © 2020 Esti Tweg. All rights reserved.
//

import UIKit


class FinderView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isOpaque = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 2
        self.layer.borderColor = Utility.transparentTurquois.cgColor
        self.layer.cornerRadius = 7
    }
}
