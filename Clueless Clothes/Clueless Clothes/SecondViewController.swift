//
//  SecondViewController.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-15.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var gallery: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<Clothes.shared.getNumberOfTops() {
            getImage(imageName: Clothes.shared.getTopName(index: i))
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for i in 0..<Clothes.shared.getNumberOfTops() {
            getImage(imageName: Clothes.shared.getTopName(index: i))
        }
    }


    func getImage(imageName: String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            gallery.image = UIImage(contentsOfFile: imagePath)
        }else{
            print("Panic! No Image!")
        }
    }
}

