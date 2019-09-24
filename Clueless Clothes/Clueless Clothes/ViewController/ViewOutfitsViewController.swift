//
//  ViewOutfitsViewController.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-01.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit


class ViewOutfitsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var outfitsCollection: UICollectionView!
    @IBOutlet weak var noOutfitsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outfitsCollection.allowsSelection = false //TODO for delete 
        outfitsCollection.dataSource = self
        outfitsCollection.delegate = self
        outfitsCollection.reloadData()
        outfitsCollection.backgroundColor = .clear
        
        
        hideIfNoOutfits()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        outfitsCollection.reloadData()
        hideIfNoOutfits()
    }
    
    func hideIfNoOutfits(){
        if Closet.shared.outfits.count == 0{
            noOutfitsLabel.isHidden = false
            outfitsCollection.isHidden = true
        }
        else{
            noOutfitsLabel.isHidden = true
            outfitsCollection.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Closet.shared.outfits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiImageCell", for: indexPath) as! MultiImageCell
        //cell.image.addGestureRecognizer(longPress) TODO
        //cell.image.isUserInteractionEnabled = true TODO
        let outfit = Closet.shared.outfits[indexPath.row]

        for item:ClothingItem in outfit.outfitItems{
            if item is Top {
                cell.topImage.image = Utility.getImage(imageName: item.imageName)
            }
            else if item is Bottom {
                cell.bottomImage.image = Utility.getImage(imageName: item.imageName)
            }
            else if item is Dress {
                cell.dressImage.image = Utility.getImage(imageName: item.imageName)
            }
            else if item is Shoes {
                cell.shoesImage.image = Utility.getImage(imageName: item.imageName)
            }/*
            else if item is Jacket {
                cell. Image.image = Utility.getImage(imageName: item.imageName)
            } TODO Jacket*/
        }
        return cell
    }
    

    
}

