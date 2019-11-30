//
//  ChangeOutfitComponentsViewController.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2019-08-04.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit

protocol ShowCollectionsDelegate {
    func updateShowCollectons(tops: Bool, dresses: Bool, jackets: Bool, bottoms: Bool, shoes: Bool)
}

class ChangeOutfitComponentsViewController: UIViewController {
    
    @IBOutlet weak var topSwitch: UISwitch!
    @IBOutlet weak var jacketSwitch: UISwitch!
    @IBOutlet weak var dressSwitch: UISwitch!
    @IBOutlet weak var bottomsSwitch: UISwitch!
    @IBOutlet weak var shoesSwitch: UISwitch!
    @IBOutlet weak var mainView: UIView!
    
    var tops: Bool!
    var dresses: Bool!
    var jackets: Bool!
    var bottoms: Bool!
    var shoes: Bool!
    
    var delegate: ShowCollectionsDelegate?
    
    //@IBOutlet weak var xView: UIView!
    
    
    override func viewDidLoad(){
        topSwitch.setOn(tops, animated: false)
        bottomsSwitch.setOn(bottoms, animated: false)
        shoesSwitch.setOn(shoes, animated: false)
        jacketSwitch.setOn(jackets, animated: false)
        dressSwitch.setOn(dresses, animated: false)
    }
    
    func checkColorTheme(){
            if #available(iOS 12.0, *) {
    //            https://stackoverflow.com/questions/56457395/how-to-check-for-ios-dark-mode
                if self.traitCollection.userInterfaceStyle == .dark {
                    UINavigationBar.appearance().barTintColor = .black
                    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
                    mainView.backgroundColor = UIColor(displayP3Red: 140/255, green: 54/255, blue: 72/255, alpha: 1.0)
                }
                else {
                    UINavigationBar.appearance().backgroundColor = UIColor(displayP3Red: 255/255, green: 255/255, blue: 241/255, alpha: 1.0)
                    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
                    mainView.backgroundColor = UIColor(displayP3Red: 255/255, green: 245/255, blue: 134/255, alpha: 1.0)
                }
            }
        }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
             checkColorTheme()
    }
    
    @IBAction func donePressed(_ sender: Any) {
        delegate?.updateShowCollectons(tops: topSwitch.isOn, dresses: dressSwitch.isOn, jackets: jacketSwitch.isOn, bottoms: bottomsSwitch.isOn, shoes: shoesSwitch.isOn)
        (presentationController?.delegate as! MatchOutfitViewController).viewDidAppear(false)
        dismiss(animated: true, completion: nil)
    }
    
    //can't edit top switch
    @IBAction func topValueChange(_ sender: Any) {
    }
    
    @IBAction func jacketValueChange(_ sender: Any) {
        delegate?.updateShowCollectons(tops: topSwitch.isOn, dresses: dressSwitch.isOn, jackets: jacketSwitch.isOn, bottoms: bottomsSwitch.isOn, shoes: shoesSwitch.isOn)
    }
    
    //not allowed to wear a dress, top and bottoms
    @IBAction func dressValueChange(_ sender: Any) {
        if dressSwitch.isOn {
            topSwitch.setOn(false, animated: true)
            bottomsSwitch.setOn(false, animated: true)
        }
        else{
            topSwitch.setOn(true, animated: true)
            bottomsSwitch.setOn(true, animated: true)
        }
        delegate?.updateShowCollectons(tops: topSwitch.isOn, dresses: dressSwitch.isOn, jackets: jacketSwitch.isOn, bottoms: bottomsSwitch.isOn, shoes: shoesSwitch.isOn)
    }
    
    //can't edit bottom switch
    @IBAction func bottomsValueChange(_ sender: Any) {
    }
    
    
    @IBAction func shoesValueChange(_ sender: Any) {
        delegate?.updateShowCollectons(tops: topSwitch.isOn, dresses: dressSwitch.isOn, jackets: jacketSwitch.isOn, bottoms: bottomsSwitch.isOn, shoes: shoesSwitch.isOn)
    }
}
