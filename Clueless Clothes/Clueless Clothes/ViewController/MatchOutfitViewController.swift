//
//  SecondViewController.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-15.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class MatchOutfitViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var topsCollection: UICollectionView!
    //TODO dresses
    //TODO jackets
    @IBOutlet weak var bottomsCollection: UICollectionView!
    @IBOutlet weak var shoesCollection: UICollectionView!
    
    var showTops = true
    var showDresses = false
    var showJackets = false
    var showBottoms = true
    var showShoes = true
    
    var longPress = UILongPressGestureRecognizer() //TODO implement show X and delete
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionsViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        topsCollection.reloadData()
        bottomsCollection.reloadData()
        shoesCollection.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeComponents" {
            if let ChangeOutfitComponentsViewController = segue.destination as? ChangeOutfitComponentsViewController {
                ChangeOutfitComponentsViewController.tops = showTops
                ChangeOutfitComponentsViewController.dresses = showDresses
                ChangeOutfitComponentsViewController.jackets = showJackets
                ChangeOutfitComponentsViewController.bottoms = showBottoms
                ChangeOutfitComponentsViewController.shoes = showShoes 
             
                navigationItem.backBarButtonItem?.title = "Back"
            }
//            else{
//                navigationItem.backBarButtonItem?.title = "Full Parent Title"
//            }
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
    
    func setUpCollectionsViews(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        layout2.itemSize = CGSize(width: width / 2, height: width / 2)
        layout2.scrollDirection = .horizontal
        layout2.minimumInteritemSpacing = 0
        layout2.minimumLineSpacing = 0
        
        topsCollection.allowsSelection = true
        topsCollection.dataSource = self
        topsCollection.delegate = self
        topsCollection.backgroundColor = .clear
        topsCollection.collectionViewLayout = layout
        topsCollection.reloadData()
        
        bottomsCollection.allowsSelection = true
        bottomsCollection.dataSource = self
        bottomsCollection.delegate = self
        bottomsCollection.backgroundColor = .clear
        bottomsCollection.collectionViewLayout = layout2
        bottomsCollection.reloadData()
        
        shoesCollection.allowsSelection = true
        shoesCollection.dataSource = self
        shoesCollection.delegate = self
        shoesCollection.backgroundColor = .clear
//        shoesCollection.collectionViewLayout = layout
        shoesCollection.reloadData()
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteImage(_:)))
        
        topsCollection.addGestureRecognizer(longPress)
        topsCollection.isUserInteractionEnabled = true
        
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
        if collectionView == self.topsCollection{
            let name = Closet.shared.tops[indexPath.row].imageName
            cell.image.image = getImage(imageName: name ?? "")
        }
        else if collectionView == self.bottomsCollection{
            let name = Closet.shared.bottoms[indexPath.row].imageName
            cell.image.image = getImage(imageName: name ?? "")
        }
        else if collectionView == self.shoesCollection{
            let name = Closet.shared.shoes[indexPath.row].imageName
            cell.image.image = getImage(imageName: name ?? "")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
    }


    @objc func deleteImage(_ sender: UILongPressGestureRecognizer) {
        print("in handler")
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

