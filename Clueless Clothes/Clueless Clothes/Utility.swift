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
    
    static let mediumMagenta = UIColor(displayP3Red: 179/255, green: 54/255, blue: 97/255, alpha: 0.95)
    static let deepMagenta   = UIColor(displayP3Red: 140/255, green: 54/255, blue: 72/255, alpha: 1.0)
    static let softYellow    = UIColor(displayP3Red: 255/255, green: 255/255, blue: 241/255, alpha: 1.0)
    static let brightYellow  = UIColor(displayP3Red: 255/255, green: 245/255, blue: 134/255, alpha: 1.0)
    static let turquois      = UIColor(displayP3Red: 26/255, green: 151/255, blue: 184/255, alpha: 1.0)
    
    
}

