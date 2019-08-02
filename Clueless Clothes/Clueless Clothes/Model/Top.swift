//
//  Top.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-01.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation


class Top : ClothingItem {
    
    override init(imageName: String) {
        super.init(imageName: imageName)
        self.maxOutfitItemCount = 4 // shoes, top, bottom, jacket
    }
}
