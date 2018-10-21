//
//  ImageCell.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-20.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit

class ImageCell : UICollectionViewCell{
    
    @IBOutlet weak var image: UIImageView!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
