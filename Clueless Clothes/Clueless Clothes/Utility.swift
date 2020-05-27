//
//  Utility.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-09-19.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    
    static func getPath(name: String) -> String {
        return (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(name)
    }
    
    static func getImage(imageName: String) -> UIImage {
        let imagePath = self.getPath(name: imageName)
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: imagePath) {
             return UIImage(contentsOfFile: imagePath)!
        }
        else {
            print("Panic! No Image!")
            return UIImage(named: "placeholder")!
        }
    }
    
    static func imageExists(imageName: String) -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(imageName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    static func removeImage(imageName: String) {
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        do {
            try fileManager.removeItem(atPath: imagePath)
        }
        catch {
            print("could not remove image")
        }
    }
    
    static let mediumMagenta = UIColor(displayP3Red: 179/255, green: 54/255, blue: 97/255, alpha: 0.95)
    static let deepMagenta   = UIColor(displayP3Red: 140/255, green: 54/255, blue: 72/255, alpha: 1.0)
    static let softYellow    = UIColor(displayP3Red: 255/255, green: 255/255, blue: 241/255, alpha: 1.0)
    static let brightYellow  = UIColor(displayP3Red: 255/255, green: 245/255, blue: 134/255, alpha: 1.0)
    static let turquois      = UIColor(displayP3Red: 26/255, green: 151/255, blue: 184/255, alpha: 1.0)
    static let transparentTurquois      = UIColor(displayP3Red: 26/255, green: 151/255, blue: 184/255, alpha: 0.55)
    
    
}

