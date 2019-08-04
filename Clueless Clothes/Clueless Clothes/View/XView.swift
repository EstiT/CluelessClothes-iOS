//
//  XView.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-04.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit


class XView : UIView {
    
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
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.closePath()
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor(displayP3Red: 26/255, green: 151/255, blue: 184/255, alpha: 1.0).cgColor)
        context.strokePath()
    }
}
