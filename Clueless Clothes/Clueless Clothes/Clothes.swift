//
//  Clothes.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-20.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import Foundation

final class Clothes{
    static let shared = Clothes()
    
    
    static var  topsImageNames = [String]()
    static var bottomsImageNames = [String]()
    
    private init() { }
    
    func getTopName(index: Int) -> String{
        if Clothes.topsImageNames.count < index {
            return ""
        }
        return Clothes.topsImageNames[index]
    }
    
    func getBottomName(index: Int) -> String{
        if Clothes.bottomsImageNames.count < index {
            return ""
        }
        return Clothes.bottomsImageNames[index]
    }
    
    func addBottom(bottomName: String){
        Clothes.bottomsImageNames.append(bottomName)
    }
    
    func addTop(topName: String){
        Clothes.topsImageNames.append(topName)
    }
    
    func getNextTopName() -> String{
        return "image" + String(Clothes.topsImageNames.count)
    }
    
    func getNextBottomName() -> String{
        return "image" + String(Clothes.bottomsImageNames.count)
    }
    
    func getNumberOfTops() -> Int{
        return Clothes.topsImageNames.count
    }
    
    func getNumberOfBottoms() -> Int{
        return Clothes.bottomsImageNames.count
    }
}
