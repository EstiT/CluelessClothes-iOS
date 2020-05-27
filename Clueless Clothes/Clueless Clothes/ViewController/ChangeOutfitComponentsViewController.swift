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
    
    
    override func viewDidLoad(){
        topSwitch.setOn(tops, animated: false)
        bottomsSwitch.setOn(bottoms, animated: false)
        shoesSwitch.setOn(shoes, animated: false)
        jacketSwitch.setOn(jackets, animated: false)
        dressSwitch.setOn(dresses, animated: false)
        
        topSwitch.isEnabled = false
        bottomsSwitch.isEnabled = false
        
        checkColorTheme()
        UISwitch.appearance().onTintColor = Utility.turquois
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkColorTheme()
    }
    
    func checkColorTheme(){
        UINavigationBar.appearance().tintColor = Utility.turquois
            if #available(iOS 12.0, *) {
//              https://stackoverflow.com/questions/56457395/how-to-check-for-ios-dark-mode
//              https://stackoverflow.com/questions/599405/iphone-navigation-bar-title-text-color
//              https://stackoverflow.com/questions/1720376/change-color-of-uiswitch-appwise
                if self.traitCollection.userInterfaceStyle == .dark {
                    UINavigationBar.appearance().barTintColor = .black
                    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
                    navigationController?.navigationBar.barTintColor = UIColor.darkGray //TODO?!!
                    mainView.backgroundColor = Utility.deepMagenta
                }
                else {
                    UINavigationBar.appearance().barTintColor = .none
                    UINavigationBar.appearance().backgroundColor = Utility.softYellow
                    navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
                    mainView.backgroundColor = Utility.brightYellow
                    navigationController?.navigationBar.barTintColor = UIColor.white
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
