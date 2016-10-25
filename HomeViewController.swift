//
//  HomeViewController.swift
//  IGClone
//
//  Created by Corey Malek on 10/24/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentImagePicker(sourceType: .photoLibrary)
        
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        
        
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func presentActionSheet() {
        
        let actionSheet = UIAlertController(title: "Source", message: "Select Source Type", preferredStyle: .actionSheet)
        
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.presentImagePicker(sourceType: .camera)
        })
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) {
            (action) in
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
        
        imagePicker.allowsEditing = true

    }
    
    @IBAction func imageTapped(_ sender: AnyObject) {
        presentActionSheet()
        
    
    }
    
    
}




extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imageView.image = originalImage
            self.dismiss(animated: true, completion: nil)

        }
        
        if let editedImage = info [UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = editedImage
            
        }
    }
    
}

// TODO:
// create outlet to image view
// take original image, put it on image view



















