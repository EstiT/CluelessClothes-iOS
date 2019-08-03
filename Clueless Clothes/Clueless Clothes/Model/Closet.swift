//
//  Closet.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-02.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation

class Closet{
    
    static let shared = Closet()

    
    var clothes = [ClothingItem]()
    var outfits = [Outfit]()
    var topsCount = 0
    var dressCount = 0
    var bottomsCount = 0
    var jacketsCount = 0
    var shoesCount = 0
    
    private init() { }

    
    func addTop(top:ClothingItem){
        clothes.append(top)
        topsCount = topsCount+1
    }
    
    func addDress(dress:ClothingItem){
        clothes.append(dress)
        dressCount = dressCount+1
    }
    
    func addJacket(jacket:ClothingItem){
        clothes.append(jacket)
        jacketsCount = jacketsCount+1
    }
    
    func addBottom(bottom:ClothingItem){
        clothes.append(bottom)
        bottomsCount = bottomsCount+1
    }
    
    func addShoes(shoes:ClothingItem){
        clothes.append(shoes)
        shoesCount = shoesCount+1
    }
    
    func addOutfit(outfit:Outfit){
        outfits.append(outfit)
    }
    
    
    //works for tops, jackets, bottoms and shoes
    func removeClothingItem(name:String){
        var i = 0
        for clothe in clothes {
            if clothe.imageName == name {
                clothes.remove(at:i)
                break
            }
            i = i+1
        }
    }
    
    func getNextTopName() -> String{ //starts at 0
        return "top" + String(topsCount)
    }
    
    func getNextDressName() -> String{
        return "dress" + String(dressCount)
    }
    
    func getNextJacketName() -> String{
        return "jacket" + String(jacketsCount)
    }
    
    func getNextBottomName() -> String{
        return "bottom" + String(bottomsCount)
    }
    
    func getNextShoesName() -> String{
        return "bottom" + String(bottomsCount)
    }


    
    
}
