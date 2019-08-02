//
//  Clothes.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-20.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import Foundation

class ClothingItem{
    
    var imageName : String!
    var maxOutfitItemCount : Int!
    var minOutfitItemCount = 2 // something and shoes
//    var id : String!

    init() {
        imageName = ""
        maxOutfitItemCount = 0
    }
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
}
