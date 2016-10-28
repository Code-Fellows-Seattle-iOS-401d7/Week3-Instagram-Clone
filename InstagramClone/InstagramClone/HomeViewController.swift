//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/24/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit
import Social

class HomeViewController: UIViewController {
    
    @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imagePickedImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    var imagesArrayForUndo = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentImagePicker(sourceType: .photoLibrary)
        
        if let galleryController = self.tabBarController?.viewControllers?[1] as? GalleryViewController {
            galleryController.delegate = self
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        postButtonBottomConstraint.constant = 100
        stackViewTopConstraint.constant = 100
        self.view.layoutIfNeeded()
        
        postButtonBottomConstraint.constant = 8
        stackViewTopConstraint.constant = 8
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
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
   
    // MARK: Action Functions
    
    @IBAction func imageTapped(_ sender: AnyObject) {
        presentActionSheet()
    }
    
    @IBAction func imageLongPressed(_ sender: UILongPressGestureRecognizer) {
        
        guard let composeController = SLComposeViewController(forServiceType: SLServiceTypeTwitter) else { return }
        
        composeController.add(imagePickedImageView.image)
        
        self.present(composeController, animated: true, completion: nil)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == FiltersPreviewController.identifier {
            if let filterController = segue.destination as? FiltersPreviewController {
                filterController.post = Post(image: self.imagePickedImageView.image!)
                filterController.delegate = self
            }
        }
    }
    
    @IBAction func filterButtonPressed(_ sender: AnyObject) {
        // causes silent failure if no image has been picked yet!
        guard self.imagePickedImageView.image != nil else { return }
        
        self.performSegue(withIdentifier: FiltersPreviewController.identifier, sender: nil)
    }
    
    @IBAction func undoButtonPressed(_ sender: AnyObject) {
        if self.imagesArrayForUndo.count > 1 {
            self.imagesArrayForUndo.removeLast()
            self.imagePickedImageView.image = self.imagesArrayForUndo.last
        } else {
            self.imagePickedImageView.image = self.imagesArrayForUndo.first
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
            Filters.shared.originalImage = editedImage
            self.imagesArrayForUndo.removeAll()
            self.imagesArrayForUndo.append(editedImage)
        }
        self.imagePickerControllerDidCancel(imagePicker)
    }
}

extension HomeViewController: FiltersPreviewControllerDelegate {
    
    func filtersPreviewController(selected: UIImage) {
        self.dismiss(animated: true, completion: nil)
        self.imagePickedImageView.image = selected
    }
}

extension HomeViewController: GalleryViewControllerDelegate {
    
    func galleryViewController(selected: UIImage) {
        self.imagePickedImageView.image = selected
        self.tabBarController?.selectedViewController = self
    }
}


