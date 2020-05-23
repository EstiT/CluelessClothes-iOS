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
    
    private init() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            print(fileURLs)
            let topPattern = "top[0-9]$"
            let bottomPattern = "bottom[0-9]$"
//            let jacketPattern = "jacket[0-9]$" TODO
            let dressPattern = "dress[0-9]$"
            let shoesPattern = "shoes[0-9]$"

            for url in fileURLs {
                if let _ = url.path.range(of: topPattern, options:.regularExpression) {
                    let arr = url.path.split(separator: "/")
                    let name = String(arr[arr.count-1])
                    tops.append(Top(imageName: name))
                }
                else if let _ = url.path.range(of: bottomPattern, options:.regularExpression) {
                    let arr = url.path.split(separator: "/")
                    let name = String(arr[arr.count-1])
                    bottoms.append(Bottom(imageName: name))
                }
                else if let _ = url.path.range(of: dressPattern, options:.regularExpression) {
                    let arr = url.path.split(separator: "/")
                    let name = String(arr[arr.count-1])
                    dresses.append(Dress(imageName: name))
                }
                else if let _ = url.path.range(of: shoesPattern, options:.regularExpression) {
                    let arr = url.path.split(separator: "/")
                    let name = String(arr[arr.count-1])
                    shoes.append(Shoes(imageName: name))
                }
                
            }
            
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }

    
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
