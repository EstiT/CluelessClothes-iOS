//
//  Utility.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-09-19.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit

class Utility{
    
    static func getImage(imageName: String) -> UIImage{
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            return UIImage(contentsOfFile: imagePath)!
        }else{
            print("Panic! No Image!")
            return UIImage()
        }
    }
    
    
}

