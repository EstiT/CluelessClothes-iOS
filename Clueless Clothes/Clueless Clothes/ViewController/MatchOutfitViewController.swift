//
//  SecondViewController.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-15.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class MatchOutfitViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ShowCollectionsDelegate {

    @IBOutlet weak var topsCollection: UICollectionView!
    @IBOutlet weak var dressesCollection: UICollectionView!
    //TODO jackets
    @IBOutlet weak var bottomsCollection: UICollectionView!
    @IBOutlet weak var shoesCollection: UICollectionView!
    
    var showTops: Bool!
    var showDresses: Bool!
    var showJackets: Bool!
    var showBottoms: Bool!
    var showShoes: Bool!
    
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
        showHideCollections()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        topsCollection.reloadData()
        dressesCollection.reloadData()
        bottomsCollection.reloadData()
        shoesCollection.reloadData()
        showHideCollections()
    }
    
    func updateShowCollectons(tops: Bool, dresses: Bool, jackets: Bool, bottoms: Bool, shoes: Bool) {
        showTops = tops
        showDresses = dresses
        showJackets = jackets
        showBottoms = bottoms
        showShoes = shoes
    }
    
    @IBAction func matchOutfit(_ sender: Any) {
        //TODO save current outfit to closet
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
        dressesCollection.isHidden = !showDresses
        shoesCollection.isHidden = !showShoes
        topsCollection.isHidden = !showTops
        bottomsCollection.isHidden = !showBottoms
    }
    
    func setUpCollectionViews(){
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

