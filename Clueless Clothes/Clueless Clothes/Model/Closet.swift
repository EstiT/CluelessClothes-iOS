//
//  Closet.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-02.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation

class Closet{
    let defaults = UserDefaults.standard
    static let shared = Closet()
    var clothes = [ClothingItem]()
    var outfits : [Outfit]
    var tops = [Top]()
    var dresses = [Dress]()
    var bottoms = [Bottom]()
    var jackets = [Jacket]()
    var shoes = [Shoes]()
    var outfitsCount:Int!
    var topsCount:Int!
    var dressesCount:Int!
    var bottomsCount:Int!
    var jacketsCount:Int!
    var shoesCount:Int!
    
    enum clothesTypes {
        case Top
        case Bottom
        case Dress
        case Jacket
        case Shoes
        case Unknown
    }
    
    private init() {
        if UserDefaults.standard.object(forKey: "outfits") != nil {
            let data: Data? = UserDefaults.standard.data(forKey: "outfits")
            if let decoded = data {
                do {
                    outfits = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Outfit.self], from: decoded) as! [Outfit]
                }
                catch {
                    outfits = [Outfit]()
                    defaults.set(outfits, forKey: "outfits")
                }
            }
            else {
                outfits = [Outfit]()
                defaults.set(outfits, forKey: "outfits")
            }
        }
        else {
            outfits = [Outfit]()
            defaults.set(outfits, forKey: "outfits")
        }
    
        topsCount = UserDefaults.standard.object(forKey: "topsCount") != nil ? UserDefaults.standard.integer(forKey: "topsCount") : 0
        dressesCount = UserDefaults.standard.object(forKey: "dressesCount") != nil ? UserDefaults.standard.integer(forKey: "dressesCount") : 0
        bottomsCount = UserDefaults.standard.object(forKey: "bottomsCount") != nil ? UserDefaults.standard.integer(forKey: "bottomsCount") : 0
        jacketsCount = UserDefaults.standard.object(forKey: "jacketsCount") != nil ? UserDefaults.standard.integer(forKey: "jacketsCount") : 0
        shoesCount = UserDefaults.standard.object(forKey: "shoesCount") != nil ? UserDefaults.standard.integer(forKey: "shoesCount") : 0
        
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)

            for url in fileURLs {
                let clotheType = typeofItemWith(name: url.path)
                let arr = url.path.split(separator: "/")
                let name = String(arr[arr.count-1])
                
                switch clotheType {
                    case .Top:
                       tops.append(Top(imageName: name))
                    case .Bottom:
                        bottoms.append(Bottom(imageName: name))
                    case .Dress:
                        dresses.append(Dress(imageName: name))
                    case .Shoes:
                        shoes.append(Shoes(imageName: name))
                    default:
                        print("unknown type \(name)")
                }
            }
            
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }

    
    func addTop(top:Top){
        topsCount += 1
        defaults.set(topsCount, forKey: "topsCount")
        clothes.append(top)
        tops.append(top)
    }
    
    func addDress(dress:Dress){
        dressesCount += 1
        defaults.set(dressesCount, forKey: "dressesCount")
        clothes.append(dress)
        dresses.append(dress)
    }
    
    func addJacket(jacket:Jacket){
        jacketsCount += 1
        defaults.set(jacketsCount, forKey: "jacketsCount")
        clothes.append(jacket)
        jackets.append(jacket)
    }
    
    func addBottom(bottom:Bottom){
        bottomsCount += 1
        defaults.set(bottomsCount, forKey: "bottomsCount")
        clothes.append(bottom)
        bottoms.append(bottom)
    }
    
    func addShoes(s:Shoes){
        shoesCount += 1
        defaults.set(shoesCount, forKey: "shoesCount")
        clothes.append(s)
        shoes.append(s)
    }
    
    func addOutfit(outfit:Outfit){
        outfits.append(outfit)
        do {
            let encodedOutfits = try NSKeyedArchiver.archivedData(withRootObject: outfits, requiringSecureCoding: false)
            defaults.set(encodedOutfits, forKey: "outfits")
        }
        catch {
            print("couldnt decode outfits")
        }
            
    }
    
    func typeofItemWith(name: String) -> clothesTypes{
        let topPattern = "top[0-9]*$"
        let bottomPattern = "bottom[0-9]*$"
        //     let jacketPattern = "jacket[0-9]$" TODO
        let dressPattern = "dress[0-9]*$"
        let shoesPattern = "shoes[0-9]*$"
        
        if let _ = name.range(of: topPattern, options:.regularExpression) {
            return .Top
        }
        else if let _ = name.range(of: bottomPattern, options:.regularExpression) {
            return .Bottom
        }
        else if let _ = name.range(of: dressPattern, options:.regularExpression) {
            return .Dress
        }
        else if let _ = name.range(of: shoesPattern, options:.regularExpression) {
            return .Shoes
        }
            
        return .Unknown
    }
    
    
    //TODO jackets
    func removeClothingItem(name:String){
        let clotheType = typeofItemWith(name: name)
        switch clotheType {
        case .Top:
            tops = tops.filter { $0.imageName != name }
        case .Bottom:
            bottoms = bottoms.filter { $0.imageName != name }
        case .Dress:
            dresses = dresses.filter { $0.imageName != name }
        case .Shoes:
            shoes = shoes.filter { $0.imageName != name }
        default:
            print("unknown type")
        }
        
        clothes = clothes.filter { $0.imageName != name }
    }
    
    func removeOutfit(index:Int){
        outfits.remove(at: index)
        do {
            let encodedOutfits = try NSKeyedArchiver.archivedData(withRootObject: outfits, requiringSecureCoding: false)
            defaults.set(encodedOutfits, forKey: "outfits")
        }
        catch {
            print("couldnt decode outfits")
        }
    }
    
    func getNextTopName() -> String{ //starts at 0
        return "top" + String(topsCount)
    }
    
    func getNextDressName() -> String{
        return "dress" + String(dressesCount)
    }
    
    func getNextJacketName() -> String{
        return "jacket" + String(jacketsCount)
    }
    
    func getNextBottomName() -> String{
        return "bottom" + String(bottomsCount)
    }
    
    func getNextShoesName() -> String{
        return "shoes" + String(shoesCount)
    }


    
    
}
