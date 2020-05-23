//
//  Outfit.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-01.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation


class Outfit: NSObject, NSCoding {
    var outfitItems = [ClothingItem]()
    
    init(clothes: [ClothingItem]) {
        outfitItems = clothes
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(outfitItems, forKey: "outfitItems")
    }
    
    required convenience init?(coder: NSCoder) {
        let outfitItems = coder.decodeObject(forKey: "outfitItems") as! [ClothingItem]
        self.init(clothes: outfitItems)
    }
    
}
