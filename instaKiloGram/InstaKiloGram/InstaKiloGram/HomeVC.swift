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

    @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func filterButtonPressed(_ sender: AnyObject) {
        guard let image = self.imageView.image else { return } // if no image yet, button won't do anything(fail silently)
        
        let actionSheet = UIAlertController(title: "Filters", message: "Choose as filter", preferredStyle: .actionSheet)
        
        let resetAction = UIAlertAction(title: "Reset", style: .destructive) { (action) in
            self.imageView.image = Filters.originalImage
        }
        
        let bwAction = UIAlertAction(title: "Black & White", style: .default) { (action) in
            Filters.blackAndWhite(image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        let vintageAction = UIAlertAction(title: "Vintage", style: .default) { (action) in
            Filters.vintage(image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        let chromeAction = UIAlertAction(title: "Chrome", style: .default) { (action) in
            Filters.chrome(image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        let fadeAction = UIAlertAction(title: "Fade", style: .default) { (action) in
            Filters.fade(image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        let instantAction = UIAlertAction(title: "Instant", style: .default) { (action) in
            Filters.instant(image: image, completion: { (filteredImage) in
                self.imageView.image = filteredImage
            })
        }
        
        actionSheet.addAction(bwAction)
        actionSheet.addAction(vintageAction)
        actionSheet.addAction(chromeAction)
        actionSheet.addAction(fadeAction)
        actionSheet.addAction(instantAction)
        actionSheet.addAction(resetAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        postButtonBottomConstraint.constant = 100
        filterButtonTopConstraint.constant = 100
        self.view.layoutIfNeeded()
        
        postButtonBottomConstraint.constant = 8
        filterButtonTopConstraint.constant = 8
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1.0) {
            self.view.layoutIfNeeded()
        }
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
    
    @IBAction func postImagePressed(_ sender: AnyObject) {
        //check if image on imageView(picked from imagePicker
        if let image = imageView.image {
            let newPost = Post(image: image)
            
            API.shared.save(post: newPost, completion: { (success) in
                if success {
                    print("New Post was saved to cloudKit!")
                    let selector = #selector(HomeVC.image(_: didFinishSaving:context:))
                    UIImageWriteToSavedPhotosAlbum(image, self, selector , nil)
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
}


extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView.image = editedImage
            Filters.originalImage = editedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
}
