//
//  FirstViewController.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-15.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit
import Photos

class AddClothesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image:UIImage!
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    var clothingOptions: [String] = ["top", "jacket", "dress", "bottom", "shoes"]
    var selectedClothingItem = 0
    
    var clothes = [ClothingItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        checkPermission()
    }
    
    
    @IBAction func selectPhoto(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion: nil)
    }


    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage // can be   used to display image
        //determine type of clothing, save image, add item to closet
        if selectedClothingItem == 0 { // top
            let name = Closet.shared.getNextTopName()
            let top = Top(imageName: name)
            Closet.shared.addTop(top:top)
            saveImage(imageName: name)
        }
        else if selectedClothingItem == 1 { //jacket
            let name = Closet.shared.getNextJacketName()
            let jacket = Jacket(imageName: name)
            Closet.shared.addJacket(jacket:jacket)
            saveImage(imageName: name)
        }
        else if selectedClothingItem == 2 { //dress
            let name = Closet.shared.getNextDressName()
            let dress = Dress(imageName: name)
            Closet.shared.addDress(dress:dress)
            saveImage(imageName: name)
        }
        else if selectedClothingItem == 3 { //bottom
            let name = Closet.shared.getNextBottomName()
            let bottom = Bottom(imageName: name)
            Closet.shared.addBottom(bottom:bottom)
            saveImage(imageName: name)
        }
        else if selectedClothingItem == 4 { //shoes
            let name = Closet.shared.getNextShoesName()
            let shoes = Shoes(imageName: name)
            Closet.shared.addShoes(s:shoes)
            saveImage(imageName: name)
        }
        dismiss(animated:true, completion:{
            //TODO indicate success check mark/saved
            })
    }
    
//    ["top", "jacket", "dress", "bottom", "shoes"]
    @IBAction func takeTopPicture(){
        selectedClothingItem = 0
        takePhoto()
    }
    
    @IBAction func takeJacketPicture(){
        selectedClothingItem = 1
        takePhoto()
    }
    
    @IBAction func takeDressPicture(){
        selectedClothingItem = 2
        takePhoto()
    }
    
    @IBAction func takeBottomPicture(){
        selectedClothingItem = 3
        takePhoto()
    }
    
    @IBAction func takeShoesPicture(){
        selectedClothingItem = 4
        takePhoto()
    }
    
    func takePhoto() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
  

    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    //https://appsandbiscuits.com/take-save-and-retrieve-a-photo-ios-13-4312f96793ff
    func saveImage(imageName: String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        image = image!.fixOrientation()
        let data = image.pngData()
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    

}

//https://stackoverflow.com/questions/10850184/ios-image-get-rotated-90-degree-after-saved-as-png-representation-data
extension UIImage {
    func fixOrientation() -> UIImage {
        if self.imageOrientation == UIImage.Orientation.up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? self.images![0]
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
}
