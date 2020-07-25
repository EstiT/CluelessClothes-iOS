//
//  ArrowView.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-09-23.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import UIKit


class ArrowView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))

        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/2.0))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.closePath()
        
        context.setFillColor(UIColor.lightGray.cgColor)
        context.fillPath()
    }
}
