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
    

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    var clothingOptions: [String] = ["Top", "Bottom"]
    static var selectedClothing = 0
    
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
    let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage

    //determine type of clothing, save image, add item TODO
//    if AddClothesViewController.selectedClothing == 0 {
//        let name = Clothes.shared.getNextTopName()
//        saveImage(imageName: name)
//        Clothes.shared.addTop(topName: name)
//    }
//    else{
//        let name = Clothes.shared.getNextBottomName()
//        saveImage(imageName: name)
//        Clothes.shared.addBottom(bottomName: name)
//    }
    dismiss(animated:true, completion: nil)
    }
    
    @IBAction func takeTopPicture(){
        takePhoto()
    }
    
    @IBAction func takeJacketPicture(){
        takePhoto()
    }
    
    @IBAction func takeBottomPicture(){
        takePhoto()
    }
    
    @IBAction func takeShoesPicture(){
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
        let image = imageView.image!.fixOrientation()
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
