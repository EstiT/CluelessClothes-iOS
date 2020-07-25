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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 2
        self.layer.borderColor = Utility.transparentTurquois.cgColor
        self.layer.cornerRadius = 7
//        guard let context = UIGraphicsGetCurrentContext() else { return }
//        context.setStrokeColor(Utility.transparentTurquois.cgColor)
//        let rectangle = CGRect(x: 0, y: 100, width: 320, height: 100)
//        context.stroke(rectangle)
//        context.setFillColor(UIColor.clear.cgColor)
    }
}
