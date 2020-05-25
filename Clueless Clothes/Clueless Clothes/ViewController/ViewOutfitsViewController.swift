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
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outfitsCollection.allowsSelection = false //TODO for delete 
        outfitsCollection.dataSource = self
        outfitsCollection.delegate = self
        outfitsCollection.backgroundColor = .clear
        
        viewDidAppear(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        outfitsCollection.reloadData()
        hideIfNoOutfits()
        checkColorTheme()
        setUpCollectionView(cv: outfitsCollection, frame: CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height))
    }
    
    func checkColorTheme(){
            if #available(iOS 12.0, *) {
    //            https://stackoverflow.com/questions/56457395/how-to-check-for-ios-dark-mode
                var statusbarColor = UIColor()
                if self.traitCollection.userInterfaceStyle == .dark {
                    topView.backgroundColor = .darkGray
                    mainView.backgroundColor = Utility.deepMagenta
                    statusbarColor = .darkGray
                }
                else {
                    topView.backgroundColor = Utility.softYellow
                    mainView.backgroundColor = Utility.brightYellow
                    statusbarColor = Utility.softYellow
                }
    //            https://freakycoder.com/ios-notes-13-how-to-change-status-bar-color-1431c185e845
                if #available(iOS 13.0, *) {
                    let app = UIApplication.shared
                    let statusBarHeight: CGFloat = app.statusBarFrame.size.height
                    
                    let statusbarView = UIView()
                    statusbarView.backgroundColor = statusbarColor
                    view.addSubview(statusbarView)
                  
                    statusbarView.translatesAutoresizingMaskIntoConstraints = false
                    statusbarView.heightAnchor
                        .constraint(equalToConstant: statusBarHeight).isActive = true
                    statusbarView.widthAnchor
                        .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
                    statusbarView.topAnchor
                        .constraint(equalTo: view.topAnchor).isActive = true
                    statusbarView.centerXAnchor
                        .constraint(equalTo: view.centerXAnchor).isActive = true
                }
                else {
                    let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
                    statusBar?.backgroundColor = statusbarColor
                }
            }
        }
        
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        checkColorTheme()
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
    
    func setUpCollectionView(cv: UICollectionView, frame: CGRect){
        cv.allowsSelection = true
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        cv.frame = frame
        let itemWidth = frame.width - 20
        let itemSize = CGSize(width: itemWidth, height: frame.height)
        if let collectionViewFlowLayout = cv.collectionViewLayout as? WLCollectionViewLayout {
            collectionViewFlowLayout.itemSize = itemSize
            collectionViewFlowLayout.minimumLineSpacing = 30
            collectionViewFlowLayout.scrollDirection = .horizontal
        }

        cv.isPagingEnabled = false
        cv.reloadData()
        cv.isUserInteractionEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Closet.shared.outfits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiImageCell", for: indexPath) as! MultiImageCell
        //cell.image.addGestureRecognizer(longPress) TODO
        //cell.image.isUserInteractionEnabled = true TODO
        
        cell.topImage.image = UIImage()
        cell.bottomImage.image = UIImage()
        cell.dressImage.image = UIImage()
        cell.shoesImage.image = UIImage()
        
        let outfit = Closet.shared.outfits[indexPath.row]
        var missingImageCount = 0
        
        for item:ClothingItem in outfit.outfitItems {
            var name = ""
            if item is Top {
                cell.topImage.image = Utility.getImage(imageName: item.imageName)
                if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
                name = item.imageName
            }
            else if item is Bottom {
                cell.bottomImage.image = Utility.getImage(imageName: item.imageName)
                if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
                name = item.imageName
            }
            else if item is Dress {
                cell.dressImage.image = Utility.getImage(imageName: item.imageName)
                if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
                name = item.imageName
            }
            else if item is Shoes {
                cell.shoesImage.image = Utility.getImage(imageName: item.imageName)
                if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
                name = item.imageName
            }/*
            else if item is Jacket {
                cell. Image.image = Utility.getImage(imageName: item.imageName)
             if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
            } TODO Jacket*/
            
            cell.topImage.contentMode = .scaleAspectFill
            cell.bottomImage.contentMode = .scaleAspectFill
            cell.dressImage.contentMode = .scaleAspectFill
            cell.shoesImage.contentMode = .scaleAspectFill
            cell.id = name
        }
        if missingImageCount == outfit.outfitItems.count {
            // all items in outfit are removed
            Closet.shared.removeOutfit(index:indexPath.row)
            outfitsCollection.reloadData()
        }
        
        return cell
    }
    

    
}

