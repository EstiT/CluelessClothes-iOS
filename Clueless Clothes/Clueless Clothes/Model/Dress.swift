//
//  Dress.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-01.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation


class Dress : ClothingItem {
    
    override init(imageName: String) {
        super.init(imageName: imageName)
        self.maxOutfitItemCount = 3 // shoes, dress, jacket 
    }
    
}