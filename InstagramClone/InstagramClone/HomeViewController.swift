//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/24/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var imagePickedImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentImagePicker(sourceType: .photoLibrary)

        // Do any additional setup after loading the view.
    }

    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "", message: "Please select Source Type", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.presentImagePicker(sourceType: .camera)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
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
    
    @IBAction func postButtonPressed(_ sender: AnyObject) {
        
        if let image = imagePickedImageView.image {
            let newPost = Post(image: image)
            
            API.shared.save(post: newPost, completion: { (success) in
                if success {
                    print("New Post was saved to CloudKit.")
                    
                    let selector  = #selector(HomeViewController.image(_:didFinishSaving:context:))
                    
                    UIImageWriteToSavedPhotosAlbum(image, self, selector, nil)
                }
            })
        }
    }
    
    func image(_ image: UIImage, didFinishSaving error: NSError?, context: UnsafeRawPointer) {
        if error == nil {
            let alert = UIAlertController(title: "Saved", message: "Your image was saved to your photos.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}


extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imagePickedImageView.image = editedImage
        }
        
        self.imagePickerControllerDidCancel(imagePicker)
    }
    
}

