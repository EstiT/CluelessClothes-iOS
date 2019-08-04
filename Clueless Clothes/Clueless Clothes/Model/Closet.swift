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
    var tops = [Top]()
    var dresses = [Dress]()
    var bottoms = [Bottom]()
    var jackets = [Jacket]()
    var shoes = [Shoes]()
    
    private init() { }

    
    func addTop(top:Top){
        clothes.append(top)
        tops.append(top)
    }
    
    func addDress(dress:Dress){
        clothes.append(dress)
        dresses.append(dress)
    }
    
    func addJacket(jacket:Jacket){
        clothes.append(jacket)
        jackets.append(jacket)
    }
    
    func addBottom(bottom:Bottom){
        clothes.append(bottom)
        bottoms.append(bottom)
    }
    
    func addShoes(s:Shoes){
        clothes.append(s)
        shoes.append(s)
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
        return "top" + String(tops.count)
    }
    
    func getNextDressName() -> String{
        return "dress" + String(dresses.count)
    }
    
    func getNextJacketName() -> String{
        return "jacket" + String(jackets.count)
    }
    
    func getNextBottomName() -> String{
        return "bottom" + String(bottoms.count)
    }
    
    func getNextShoesName() -> String{
        return "shoes" + String(shoes.count)
    }


    
    
}
