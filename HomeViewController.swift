//
//  HomeViewController.swift
//  IGClone
//
//  Created by Corey Malek on 10/24/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    
    @IBOutlet weak var filterButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        presentImagePicker(sourceType: .photoLibrary)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        postButtonBottomConstraint.constant = 100
        filterButtonTopConstraint.constant = 100
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        
        self.imagePicker.allowsEditing = true
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
        

    }
    
    
    
    @IBAction func imageTapped(_ sender: AnyObject) {
        presentActionSheet()
    }
    
    
    
    @IBAction func filterButtonPressed(_ sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        
        let actionSheet = UIAlertController(title: "Filters", message: "Please Pick A Filter", preferredStyle: .actionSheet)
        
        let bwAction = UIAlertAction(title: "Black & White", style: .default) {(action) in
            Filters.blackAndWhite(image: image, completion: {(filteredImage) in
            self.imageView.image = filteredImage
            })
        
    }
        let vintageAction = UIAlertAction(title: "Vintage", style: .default) {(action) in
            Filters.vintage(image: image, completion: {(filteredImage) in
                self.imageView.image =
                filteredImage
            })
            
        }
        
        let chromeAction = UIAlertAction(title: "Chrome", style: .default) {(action) in Filters.chrome(image: image, completion: {(filteredImage) in
            self.imageView.image =
            filteredImage
        })
            
    }
        let noirAction = UIAlertAction(title: "Noir", style: .default) {(action) in Filters.noir(image: image, completion: {(filteredImage) in
            self.imageView.image =
            filteredImage
        })
    }
        let colorInvertAction = UIAlertAction(title: "Color Invert", style: .default) {(action) in Filters.colorInvert(image: image, completion: {(filteredImage) in
            self.imageView.image =
            filteredImage
        })
    }
    
        let resetAction = UIAlertAction(title: "Reset", style: .destructive) {(action) -> Void in
            self.imageView.image = Filters.originalImage
        }
        
        
        actionSheet.addAction(bwAction)
        actionSheet.addAction(vintageAction)
        actionSheet.addAction(chromeAction)
        actionSheet.addAction(noirAction)
        actionSheet.addAction(colorInvertAction)
        actionSheet.addAction(resetAction)
        self.present(actionSheet, animated: true, completion: nil)
    
}


    @IBAction func postButtonPressed(_ sender: AnyObject) {
        if let image = imageView.image {
            let newPost = Post(image: image)
            
            API.shared.save(post: newPost, completion: { (success) in
                if success {
                    print("New Post was saved to CloudKit.")
                    let selector = #selector(HomeViewController.image(_:didFinishSaving:context:))
                    
                    UIImageWriteToSavedPhotosAlbum(image, self, selector, nil)
                }
            })
        }
        
    }
    
    
    
    
    

    func image(_ image: UIImage, didFinishSaving error: NSError?, context: UnsafeRawPointer) {
        if error == nil {
            let alert = UIAlertController(title: "Saved!", message: "Your image was saved to your photos!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
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
            Filters.originalImage = editedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}





















