//
//  HomeVC.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/24/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    // create instance of UIIPC
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentImagePicker(sourceType: .camera)
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self //becoming the delegate
        self.imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
        self.imagePicker.allowsEditing = true
    }
    
    //implement actionSheet
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Source", message: "Select cource type", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            //code that fires off when they present camera
            self.presentImagePicker(sourceType: .camera)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .destructive) { (action) in
            self.presentImagePicker(sourceType: .photoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraAction.isEnabled = false
        }
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoLibraryAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func imageTapped(_ sender: AnyObject) {
        presentActionSheet()
    }
}


extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //take original image and put on imageView
            imageView.image = originalImage
            self.dismiss(animated: true, completion: nil)
        }
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = editedImage
            self.dismiss(animated: true, completion: nil)
        }
    }
}
