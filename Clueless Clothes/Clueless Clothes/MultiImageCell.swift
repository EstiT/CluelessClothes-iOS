//
//  MultiImageCell.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-09-19.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit

class MultiImageCell : UICollectionViewCell{

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomImage: UIImageView!
    @IBOutlet weak var dressImage: UIImageView!
    @IBOutlet weak var shoesImage: UIImageView!
//    @IBOutlet weak var jacketImage: UIImageView! TODO 
    var id: String!

    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

}
