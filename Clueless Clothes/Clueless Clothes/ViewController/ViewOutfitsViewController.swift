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
    }
    
    func checkColorTheme(){
            if #available(iOS 12.0, *) {
    //            https://stackoverflow.com/questions/56457395/how-to-check-for-ios-dark-mode
                var statusbarColor = UIColor()
                if self.traitCollection.userInterfaceStyle == .dark {
                    topView.backgroundColor = .darkGray
                    mainView.backgroundColor = UIColor(displayP3Red: 140/255, green: 54/255, blue: 72/255, alpha: 1.0)
                    statusbarColor = .darkGray
                }
                else {
                    topView.backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 241/255, alpha: 1.0)
                    mainView.backgroundColor = UIColor(displayP3Red: 255/255, green: 245/255, blue: 134/255, alpha: 1.0)
                    statusbarColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 241/255, alpha: 1.0)
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

