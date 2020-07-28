//
//  AddClothesViewController.swift
//  Clueless Clothes
//
//  Created by Esti Tweg on 2018-10-15.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit
import Photos


class AddClothesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var image: UIImage!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    var viewfinder:UIImageView!
    var overlayView:UIView!
    let imagePicker = UIImagePickerController()
    var selectedClothingItem:Closet.clothesTypes!
    var clothes = [ClothingItem]()
    let isSimulator = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        if isSimulator {
            imagePicker.sourceType = .photoLibrary
        }
        else {
            imagePicker.sourceType = .camera
            setCameraOverlay()
        }
        checkPermission()
        checkColorTheme()
    }
    
    func setCameraOverlay(){
        overlayView = UIView()
        viewfinder = UIImageView()
        if #available(iOS 13.0, *) {
            viewfinder.image = UIImage(systemName: "plus.rectangle")
        } else {
            viewfinder.image = FinderView(frame: CGRect(x: 0, y: 0, width: 50, height: 50)).asImage()
        }
        viewfinder.tintColor = Utility.transparentTurquois
        viewfinder.center = CGPoint(x:view.frame.midX, y:view.frame.midY)
        overlayView.addSubview(viewfinder)
        imagePicker.cameraOverlayView = overlayView
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"_UIImagePickerControllerUserDidCaptureItem"), object:nil, queue:nil, using:{ note in self.imagePicker.cameraOverlayView = nil})
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue:"_UIImagePickerControllerUserDidRejectItem"), object:nil, queue:nil, using:{ note in self.imagePicker.cameraOverlayView = self.overlayView})
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
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        checkColorTheme()
    }


    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = img
        }
        else if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = img
        }
        switch selectedClothingItem {
        case .Top:
            let name = Closet.shared.getNextTopName()
            let top = Top(imageName: name)
            Closet.shared.addTop(top:top)
            saveImage(imageName: name)
        
        case .Jacket:
            let name = Closet.shared.getNextJacketName()
            let jacket = Jacket(imageName: name)
            Closet.shared.addJacket(jacket:jacket)
            saveImage(imageName: name)
        
        case .Dress:
            let name = Closet.shared.getNextDressName()
            let dress = Dress(imageName: name)
            Closet.shared.addDress(dress:dress)
            saveImage(imageName: name)
        
        case .Bottom:
            let name = Closet.shared.getNextBottomName()
            let bottom = Bottom(imageName: name)
            Closet.shared.addBottom(bottom:bottom)
            saveImage(imageName: name)
        
        case .Shoes:
            let name = Closet.shared.getNextShoesName()
            let shoes = Shoes(imageName: name)
            Closet.shared.addShoes(s:shoes)
            saveImage(imageName: name)
        
        case .none:
            print("none case")
        case .some(.Unknown):
            print("unknown case")
        }
        dismiss(animated:true, completion:{
            let alert = UIAlertController(title: "Success!", message: "Image has been saved", preferredStyle: .alert)
            self.present(alert, animated:true, completion: {
                Timer.scheduledTimer(withTimeInterval: 4, repeats:false, block:
                    {_ in
                        self.dismiss(animated: true, completion: nil)
                    })
                alert.view.superview?.isUserInteractionEnabled = true
                alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            })
        })
    }
    
    @objc func alertControllerBackgroundTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func takeTopPicture(){
        if !isSimulator {
            viewfinder.frame = CGRect(x:viewfinder.frame.midX, y:viewfinder.frame.midY, width: view.frame.width, height: view.frame.height/2)
            viewfinder.center = CGPoint(x:view.frame.midX, y:view.frame.midY-40)
        }
        selectedClothingItem = Closet.clothesTypes.Top
        takePhoto()
    }
    
    @IBAction func takeJacketPicture(){
        if !isSimulator {
            viewfinder.frame = CGRect(x:viewfinder.frame.midX, y:viewfinder.frame.midY, width: view.frame.width, height: view.frame.height/2)
            viewfinder.center = CGPoint(x:view.frame.midX, y:view.frame.midY-40)
        }
        selectedClothingItem = Closet.clothesTypes.Jacket
        takePhoto()
    }
    
    @IBAction func takeDressPicture(){
        if !isSimulator {
            viewfinder.frame = CGRect(x:viewfinder.frame.midX, y:viewfinder.frame.midY, width: view.frame.width, height: view.frame.height*0.9)
            viewfinder.center = CGPoint(x:view.frame.midX, y:view.frame.midY-25)
        }
        selectedClothingItem = Closet.clothesTypes.Dress
        takePhoto()
    }
    
    @IBAction func takeBottomPicture(){
        if !isSimulator {
            viewfinder.frame = CGRect(x:viewfinder.frame.midX, y:viewfinder.frame.midY, width: view.frame.width, height: view.frame.height*0.75)
            viewfinder.center = CGPoint(x:view.frame.midX, y:view.frame.midY-25)
        }
        selectedClothingItem = Closet.clothesTypes.Bottom
        takePhoto()
    }
    
    @IBAction func takeShoesPicture(){
        if !isSimulator {
            viewfinder.frame = CGRect(x:viewfinder.frame.midX, y:viewfinder.frame.midY, width: view.frame.width, height: view.frame.height*0.2)
            viewfinder.center = CGPoint(x:view.frame.midX, y:view.frame.midY-40)
        }
        selectedClothingItem = Closet.clothesTypes.Shoes
        takePhoto()
    }
    
    func takePhoto() {
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
        @unknown default:
            print("Error")
        }
    }
    
    //https://appsandbiscuits.com/take-save-and-retrieve-a-photo-ios-13-4312f96793ff
    func saveImage(imageName: String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        image = image!.fixOrientation()
        fileManager.createFile(atPath: imagePath as String, contents: image.pngData(), attributes: nil)
    }
}

// https://stackoverflow.com/questions/10850184/ios-image-get-rotated-90-degree-after-saved-as-png-representation-data
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

// https://stackoverflow.com/questions/30696307/how-to-convert-a-uiview-to-an-image
extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
