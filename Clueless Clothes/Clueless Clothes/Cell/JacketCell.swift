//
//  JacketCell.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2021-03-19.
//  Copyright © 2021 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit

class JacketCell : UICollectionViewCell{
    
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    var id: String!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.leftImage?.frame = CGRect(x: 0, y: 0, width: 75, height: 100)
        self.rightImage?.frame = CGRect(x: 200, y: 0, width: 75, height: 100)
    }
}
