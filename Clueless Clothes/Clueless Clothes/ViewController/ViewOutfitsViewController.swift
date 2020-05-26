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
    @IBOutlet weak var editButton: UIButton!
    var deleteView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outfitsCollection.allowsSelection = false //TODO for delete 
        outfitsCollection.dataSource = self
        outfitsCollection.delegate = self
        outfitsCollection.backgroundColor = .clear
        
        viewWillAppear(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pruneOutfits()
        outfitsCollection.reloadData()
        hideIfNoOutfits()
        checkColorTheme()
        setUpCollectionView(cv: outfitsCollection, frame: CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height-50))
    }
    
    func pruneOutfits() {
        var i = 0;
        for outfit in Closet.shared.outfits {
            var missingImageCount = 0
            for item:ClothingItem in outfit.outfitItems {
                if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
            }
            if missingImageCount == outfit.outfitItems.count {
                // all items in outfit are removed
                Closet.shared.removeOutfit(index:i)
                hideIfNoOutfits()
                pruneOutfits()
                return
            }
            i+=1
        }
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
        let itemSize = CGSize(width: itemWidth, height: frame.height-20)
        if let collectionViewFlowLayout = cv.collectionViewLayout as? WLCollectionViewLayout {
            collectionViewFlowLayout.itemSize = itemSize
            collectionViewFlowLayout.minimumLineSpacing = 0
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
            
            if item is Top {
                cell.topImage.image = Utility.getImage(imageName: item.imageName)
                if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
            }
            else if item is Bottom {
                cell.bottomImage.image = Utility.getImage(imageName: item.imageName)
                if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
            }
            else if item is Dress {
                cell.dressImage.image = Utility.getImage(imageName: item.imageName)
                if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
            }
            else if item is Shoes {
                cell.shoesImage.image = Utility.getImage(imageName: item.imageName)
                if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
            }/*
            else if item is Jacket {
                cell. Image.image = Utility.getImage(imageName: item.imageName)
             if !Utility.imageExists(imageName: item.imageName) { missingImageCount+=1 }
            } TODO Jacket*/
            else {
                print("dont know what item is")
            }
        }

        cell.deleteOverlay.imageView?.contentMode = .scaleAspectFit
        if deleteView {
            cell.deleteOverlay.isHidden = false
        }
        else {
            cell.deleteOverlay.isHidden = true
        }
        
        cell.topImage.contentMode = .scaleAspectFill
        cell.bottomImage.contentMode = .scaleAspectFill
        cell.dressImage.contentMode = .scaleAspectFill
        cell.shoesImage.contentMode = .scaleAspectFill
        
        return cell
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        deleteView = !deleteView
        editButton.setTitle(deleteView ? "done" : "edit", for: .normal)
        viewWillAppear(false)
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        let confirmAlert = UIAlertController(title: "Delete outfit?", message: "Are you sure you want to delete this outfit?", preferredStyle: UIAlertController.Style.alert)
        
        confirmAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action: UIAlertAction!) in
            let visibleRect = CGRect(origin: self.outfitsCollection.contentOffset, size: self.outfitsCollection.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
            if let visibleIndexPath = self.outfitsCollection.indexPathForItem(at: visiblePoint){
                Closet.shared.removeOutfit(index: visibleIndexPath.row) // visibleIndexPath
            }
           
            self.setUpCollectionView(cv: self.outfitsCollection,
                                     frame: CGRect(x: 0, y: 0, width: self.mainView.frame.width, height: self.mainView.frame.height-50))
        }))
        
        confirmAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancelled delete")
        }))
        
        present(confirmAlert, animated: true, completion: nil)
    }
    
}

