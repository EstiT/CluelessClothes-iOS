//
//  Bottom.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-01.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation


class Bottom : ClothingItem {
    
    override init(imageName: String) {
        super.init(imageName: imageName)
    }
    
    required convenience init?(coder: NSCoder) {
        let imageName = coder.decodeObject(forKey: "imageName") as! String
        self.init(imageName: imageName)
    }
}
