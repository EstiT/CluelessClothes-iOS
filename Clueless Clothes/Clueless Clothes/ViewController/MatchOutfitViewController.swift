//
//  SecondViewController.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-15.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class MatchOutfitViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ShowCollectionsDelegate {
    
    
    enum clothesItemCombination {
        case JacketDressShoes
        case JacketDress
        case Dress
        case DressShoes
        case JacketTopBottomShoes
        case JacketTopBottom
        case TopBottom
        case TopBottomShoes
    }
    

    @IBOutlet weak var topsCollection: UICollectionView!
    @IBOutlet weak var dressesCollection: UICollectionView!
    @IBOutlet weak var jacketsCollection:UICollectionView! //TODO
    @IBOutlet weak var bottomsCollection: UICollectionView!
    @IBOutlet weak var shoesCollection: UICollectionView!
    
    @IBOutlet weak var noTopsLabel: UILabel!
    @IBOutlet weak var noDressesLabel: UILabel!
    @IBOutlet weak var noJacketsLabel: UILabel!
    @IBOutlet weak var noBottomsLabel: UILabel!
    @IBOutlet weak var noShoesLabel: UILabel!
    
    var showTops: Bool!
    var showDresses: Bool!
    var showJackets: Bool!
    var showBottoms: Bool!
    var showShoes: Bool!
    
    var selectedCombo: clothesItemCombination!
    
    var longPress = UILongPressGestureRecognizer() //TODO implement show X and delete
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if showTops == nil {
            showTops = true
        }
        if showDresses == nil {
            showDresses = false
        }
        if showJackets == nil {
            showJackets = false
        }
        if showBottoms == nil {
            showBottoms = true
        }
        if showShoes == nil {
            showShoes = true
        }
        
        setUpCollectionViews()
        setComboEnum()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUpCollectionViews()
        setComboEnum()
    }
    
    func setComboEnum(){
        if showJackets && showDresses && showShoes && !showTops && !showBottoms{
            selectedCombo = clothesItemCombination.JacketDressShoes
        }
        else if showJackets && showDresses && !showShoes && !showTops && !showBottoms{
            selectedCombo = clothesItemCombination.JacketDress
        }
        else if !showJackets && showDresses && !showShoes && !showTops && !showBottoms{
            selectedCombo = clothesItemCombination.Dress
        }
        else if !showJackets && showDresses && showShoes && !showTops && !showBottoms{
            selectedCombo = clothesItemCombination.DressShoes
        }
        else if showJackets && !showDresses && showShoes && showTops && showBottoms{
            selectedCombo = clothesItemCombination.JacketTopBottomShoes
        }
        else if showJackets && !showDresses && !showShoes && showTops && showBottoms{
            selectedCombo = clothesItemCombination.JacketTopBottom
        }
        else if !showJackets && !showDresses && !showShoes && showTops && showBottoms{
            selectedCombo = clothesItemCombination.TopBottom
        }
        else if !showJackets && !showDresses && showShoes && showTops && showBottoms{
            selectedCombo = clothesItemCombination.TopBottomShoes
        }
    }
    
    func updateShowCollectons(tops: Bool, dresses: Bool, jackets: Bool, bottoms: Bool, shoes: Bool) {
        showTops = tops
        showDresses = dresses
        showJackets = jackets
        showBottoms = bottoms
        showShoes = shoes
        
        setComboEnum()
        showHideCollections()
    }
    
    @IBAction func matchOutfit(_ sender: Any) {
        var topName:String!
        var bottomName:String!
        var dressName:String!
        var shoesName:String!
        var jacketName:String! //TODO
        
        if !topsCollection.isHidden{
            let visibleRect = CGRect(origin: topsCollection.contentOffset, size: topsCollection.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = topsCollection.indexPathForItem(at: visiblePoint){
                let cell = topsCollection.cellForItem(at: visibleIndexPath) as! ImageCell
                topName = cell.id
            }
        }
        if !bottomsCollection.isHidden{
            let visibleRect = CGRect(origin: bottomsCollection.contentOffset, size: bottomsCollection.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = bottomsCollection.indexPathForItem(at: visiblePoint){
                let cell = bottomsCollection.cellForItem(at: visibleIndexPath) as! ImageCell
                bottomName = cell.id
            }
        }
        if !dressesCollection.isHidden{
            let visibleRect = CGRect(origin: dressesCollection.contentOffset, size: dressesCollection.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = dressesCollection.indexPathForItem(at: visiblePoint){
                let cell = dressesCollection.cellForItem(at: visibleIndexPath) as! ImageCell
                dressName = cell.id
            }
        }
        /* TODO
        if !jacketsCollection.isHidden{
         
         
        }*/
        if !shoesCollection.isHidden{
            let visibleRect = CGRect(origin: shoesCollection.contentOffset, size: shoesCollection.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = shoesCollection.indexPathForItem(at: visiblePoint){
                let cell = shoesCollection.cellForItem(at: visibleIndexPath) as! ImageCell
                shoesName = cell.id
            }
        }
        
        var clothes = [ClothingItem]()
        
        switch selectedCombo {
        case .JacketDressShoes?:
            clothes = [Dress(imageName: dressName),Jacket(imageName: jacketName), Shoes(imageName: shoesName)]
            
        case .JacketDress?:
            clothes = [Dress(imageName: dressName),Jacket(imageName: jacketName)]
            
        case .Dress?:
            clothes = [Dress(imageName: dressName)]
            
        case .DressShoes?:
            clothes = [Dress(imageName: dressName), Shoes(imageName: shoesName)]
            
        case .JacketTopBottomShoes?:
            clothes = [Top(imageName: topName),Jacket(imageName: jacketName), Bottom(imageName: bottomName), Shoes(imageName: shoesName)]
            
        case .JacketTopBottom?:
            clothes = [Top(imageName: topName),Jacket(imageName: jacketName), Bottom(imageName: bottomName)]
            
        case .TopBottom?:
            clothes = [Top(imageName: topName), Bottom(imageName: bottomName)]
            
        case .TopBottomShoes?:
            clothes = [Top(imageName: topName), Bottom(imageName: bottomName), Shoes(imageName: shoesName)]
            
        default:
            print("uh oh")
        }
       
        let outfit = Outfit(clothes: clothes)
        Closet.shared.addOutfit(outfit: outfit)
        print(Closet.shared.outfits.count)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeComponents" {
            if let ChangeOutfitComponentsVC = segue.destination as? ChangeOutfitComponentsViewController {
                ChangeOutfitComponentsVC.tops = showTops
                ChangeOutfitComponentsVC.dresses = showDresses
                ChangeOutfitComponentsVC.jackets = showJackets
                ChangeOutfitComponentsVC.bottoms = showBottoms
                ChangeOutfitComponentsVC.shoes = showShoes
                
                ChangeOutfitComponentsVC.delegate = self
            }
        }
    }


    func getImage(imageName: String) -> UIImage{
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            return UIImage(contentsOfFile: imagePath)!
        }else{
            print("Panic! No Image!")
            return UIImage()
        }
    }
    
    //MARK:- CollectionView
    
    func showHideCollections(){
        if Closet.shared.tops.count > 0 {
            topsCollection.isHidden = !showTops
            noTopsLabel.isHidden = true
        }
        else if showTops{
            topsCollection.isHidden = true
            noTopsLabel.isHidden = false
        }
        else {
            noTopsLabel.isHidden = true
        }
        
        if Closet.shared.dresses.count > 0 {
            dressesCollection.isHidden = !showDresses
            noDressesLabel.isHidden = true
        }
        else if showDresses{
            dressesCollection.isHidden = true
            noDressesLabel.isHidden = false
        }
        else {
            noDressesLabel.isHidden = true
        }
        
        if Closet.shared.bottoms.count > 0 {
            bottomsCollection.isHidden = !showBottoms
            noBottomsLabel.isHidden = true
        }
        else if showBottoms{
            bottomsCollection.isHidden = true
            noBottomsLabel.isHidden = false
        }
        else {
            noBottomsLabel.isHidden = true
        }
        
        if Closet.shared.shoes.count > 0 {
            shoesCollection.isHidden = !showShoes
            noShoesLabel.isHidden = true
        }
        else if showShoes{
            shoesCollection.isHidden = true
            noShoesLabel.isHidden = false
        }
        else {
            noShoesLabel.isHidden = true
        }
    }
    
    func setUpCollectionViews(){
        showHideCollections()
        topsCollection.allowsSelection = true
        topsCollection.dataSource = self
        topsCollection.delegate = self
        topsCollection.backgroundColor = .clear
        topsCollection.reloadData()
        
        dressesCollection.allowsSelection = true
        dressesCollection.dataSource = self
        dressesCollection.delegate = self
        dressesCollection.backgroundColor = .clear
        dressesCollection.reloadData()
        
        bottomsCollection.allowsSelection = true
        bottomsCollection.dataSource = self
        bottomsCollection.delegate = self
        bottomsCollection.backgroundColor = .clear
        bottomsCollection.reloadData()
        
        shoesCollection.allowsSelection = true
        shoesCollection.dataSource = self
        shoesCollection.delegate = self
        shoesCollection.backgroundColor = .clear
        shoesCollection.reloadData()
       
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteImage(_:)))
        
        topsCollection.addGestureRecognizer(longPress)
        topsCollection.isUserInteractionEnabled = true
        
        dressesCollection.addGestureRecognizer(longPress)
        dressesCollection.isUserInteractionEnabled = true
        
        bottomsCollection.addGestureRecognizer(longPress)
        bottomsCollection.isUserInteractionEnabled = true
        
        shoesCollection.addGestureRecognizer(longPress)
        shoesCollection.isUserInteractionEnabled = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        // number of each type of clothes
        if collectionView == self.topsCollection{
            return Closet.shared.tops.count
        }
        else if collectionView == self.dressesCollection{
            return Closet.shared.dresses.count
        }
        else if collectionView == self.bottomsCollection{
            return Closet.shared.bottoms.count
        }
        else if collectionView == self.shoesCollection{
            return Closet.shared.shoes.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.image.addGestureRecognizer(longPress)
        cell.image.isUserInteractionEnabled = true
        
        //set image for colection view
        var name = ""
        if collectionView == self.topsCollection{
            name = Closet.shared.tops[indexPath.row].imageName
        }
        else if collectionView == self.dressesCollection {
            name = Closet.shared.dresses[indexPath.row].imageName
        }
        else if collectionView == self.bottomsCollection{
            name = Closet.shared.bottoms[indexPath.row].imageName
        }
        else if collectionView == self.shoesCollection{
            name = Closet.shared.shoes[indexPath.row].imageName
        }
        cell.image.image = getImage(imageName: name)
        cell.id = name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
    }


    @objc func deleteImage(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            if let indexPath = self.topsCollection?.indexPathForItem(at: sender.location(in: self.topsCollection)) {
                let cell = self.topsCollection?.cellForItem(at: indexPath) as! ImageCell
                cell.image.shake()
                print("top - you can do something with the cell or index path here")
            } else if let indexPath = self.bottomsCollection?.indexPathForItem(at: sender.location(in: self.bottomsCollection)) {
                let cell = self.bottomsCollection?.cellForItem(at: indexPath) as! ImageCell
                cell.image.shake()
                print("bottom - you can do something with the cell or index path here")
            } else if let indexPath = self.shoesCollection?.indexPathForItem(at: sender.location(in: self.shoesCollection)) {
                let cell = self.shoesCollection?.cellForItem(at: indexPath) as! ImageCell
                cell.image.shake()
                print("shoes - you can do something with the cell or index path here")
            }
                //TODO dresses & jacket 
            else {
                self.becomeFirstResponder()
                sender.view?.shake()
                print("long press")
            }
        }
    }
}

//https://stackoverflow.com/questions/3703922/how-do-you-create-a-wiggle-animation-similar-to-iphone-deletion-animation
extension UIView {
    func shake() {
        let transformAnim  = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values  = [NSValue(caTransform3D: CATransform3DMakeRotation(0.05, 0.0, 0.0, 1.0)),NSValue(caTransform3D: CATransform3DMakeRotation(-0.05 , 0, 0, 1))]
        transformAnim.autoreverses = true
        transformAnim.duration  = 0.115
        transformAnim.repeatCount = Float.infinity
        self.layer.add(transformAnim, forKey: "shake")
    }
}



