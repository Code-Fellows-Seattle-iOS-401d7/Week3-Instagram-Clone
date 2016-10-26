//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/24/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!

    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imagePickedImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    var imagesArrayForUndo = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentImagePicker(sourceType: .photoLibrary)
        
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
    
    @IBAction func filterButtonPressed(_ sender: AnyObject) {
        // causes silent failure if no image has been picked yet!
        guard let image = self.imagePickedImageView.image else { return }
        
        let actionSheet = UIAlertController(title: "Filters", message: "Please pick a filter:", preferredStyle: .actionSheet)
        
        let bwAction = UIAlertAction(title: "Black & White", style: .default) { (action) in
            Filters.blackAndWhite(image: image, completion: { (filteredImage) in
                self.imagePickedImageView.image = filteredImage
                self.imagesArrayForUndo.append(filteredImage!)
            })
        }
        
        let chromeAction = UIAlertAction(title: "Chrome", style: .default) { (action) in
            Filters.chrome(image: image, completion: { (filteredImage) in
                self.imagePickedImageView.image = filteredImage
                self.imagesArrayForUndo.append(filteredImage!)
            })
        }
        
        let invertAction = UIAlertAction(title: "Inverted", style: .default) { (action) in
            Filters.invert(image: image, completion: { (filteredImage) in
                self.imagePickedImageView.image = filteredImage
                self.imagesArrayForUndo.append(filteredImage!)
            })
        }
        
        let sepiaAction = UIAlertAction(title: "Sepia Tone", style: .default) { (action) in
            Filters.sepia(image: image, completion: { (filteredImage) in
                self.imagePickedImageView.image = filteredImage
                self.imagesArrayForUndo.append(filteredImage!)
            })
        }
        
        let vintageAction = UIAlertAction(title: "Vintage", style: .default) { (action) in
            Filters.vintage(image: image, completion: { (filteredImage) in
                self.imagePickedImageView.image = filteredImage
                self.imagesArrayForUndo.append(filteredImage!)
            })
        }
        
        let resetAction = UIAlertAction(title: "Reset", style: .destructive) { (action) in
            self.imagePickedImageView.image = Filters.originalImage
            self.imagesArrayForUndo.append(Filters.originalImage)
        }
        
        actionSheet.addAction(bwAction)
        actionSheet.addAction(chromeAction)
        actionSheet.addAction(invertAction)
        actionSheet.addAction(sepiaAction)
        actionSheet.addAction(vintageAction)
        actionSheet.addAction(resetAction)
        
        self.present(actionSheet, animated: true, completion: nil)
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
            Filters.originalImage = editedImage
            self.imagesArrayForUndo.removeAll()
            self.imagesArrayForUndo.append(editedImage)
        }
        self.imagePickerControllerDidCancel(imagePicker)
    }
    
}

