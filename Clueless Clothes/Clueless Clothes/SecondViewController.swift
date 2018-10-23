//
//  SecondViewController.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-15.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var topsCollection: UICollectionView!
    @IBOutlet weak var bottomsCollection: UICollectionView!
    var longPress = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        topsCollection.allowsSelection = true
        topsCollection.dataSource = self
        topsCollection.delegate = self
        topsCollection.reloadData()
    
        bottomsCollection.allowsSelection = true
        bottomsCollection.dataSource = self
        bottomsCollection.delegate = self
        bottomsCollection.reloadData()
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteImage(_:)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        topsCollection.reloadData()
        bottomsCollection.reloadData()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == self.topsCollection{
            return Clothes.shared.getNumberOfTops()
        }
        else if collectionView == self.bottomsCollection{
            return Clothes.shared.getNumberOfBottoms()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.image.addGestureRecognizer(longPress)
        cell.image.isUserInteractionEnabled = true
        if collectionView == self.topsCollection{
            cell.image.image = getImage(imageName: Clothes.shared.getTopName(index: indexPath.row))
        }
        else if collectionView == self.bottomsCollection{
            cell.image.image = getImage(imageName: Clothes.shared.getBottomName(index: indexPath.row))
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
        if sender.state == .began {
            self.becomeFirstResponder()
            print("long press")
            sender.view?.shake()
            
        }
    }
}

//https://stackoverflow.com/questions/3703922/how-do-you-create-a-wiggle-animation-similar-to-iphone-deletion-animation
extension UIView {
    func shake() {
        let transformAnim  = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values  = [NSValue(caTransform3D: CATransform3DMakeRotation(0.04, 0.0, 0.0, 1.0)),NSValue(caTransform3D: CATransform3DMakeRotation(-0.04 , 0, 0, 1))]
        transformAnim.autoreverses = true
        transformAnim.duration  = 0.115
        transformAnim.repeatCount = Float.infinity
        self.layer.add(transformAnim, forKey: "shake")
    }
}

