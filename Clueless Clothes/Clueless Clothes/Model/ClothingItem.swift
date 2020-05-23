//
//  Clothes.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-20.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import Foundation

class ClothingItem: NSObject, NSCoding{

    var imageName : String!

    override init() {
        imageName = ""
    }
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    func encode(with coder: NSCoder) {
  
        coder.encode(imageName, forKey: "imageName")
    }
    
    required convenience init?(coder: NSCoder) {
        let imageName = coder.decodeObject(forKey: "imageName") as! String
        self.init(imageName: imageName)
    }
}
