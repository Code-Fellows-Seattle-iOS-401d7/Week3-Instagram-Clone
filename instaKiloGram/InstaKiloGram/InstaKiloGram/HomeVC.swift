//
//  HomeVC.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/24/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit
import Social

class HomeVC: UIViewController {
    
    // create instance of UIIPC
    var imagePicker = UIImagePickerController()

    @IBOutlet var superView: UIImageView!
    @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func imageLongPressed(_ sender: UILongPressGestureRecognizer) {
        guard let composeController = SLComposeViewController(forServiceType: SLServiceTypeTwitter) else { return }
        
        composeController.add(imageView.image)
        
        self.present(composeController, animated: true, completion: nil)
    }
    
    @IBAction func filterButtonPressed(_ sender: AnyObject) {
        guard self.imageView.image != nil else { return } // if no image yet, button won't do anything(fail silently)
        self.performSegue(withIdentifier: FiltersPreviewController.identifier, sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == FiltersPreviewController.identifier {
            if let filterController = segue.destination as? FiltersPreviewController {
                filterController.post = Post(image: self.imageView.image!)
                filterController.delegate = self
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let galleryViewController =  self.tabBarController?.viewControllers?[1] as? GalleryVC{
            galleryViewController.delegate = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        postButtonBottomConstraint.constant = 100
//        filterButtonTopConstraint.constant = 100
//        self.view.layoutIfNeeded()
//        
//        postButtonBottomConstraint.constant = 8
//        filterButtonTopConstraint.constant = 8
//        
//        UIView.animate(withDuration: 1.0) {
//            self.view.layoutIfNeeded()
//        }
        
//        var blurredBackgroundImage = superView.image
//            blurredBackgroundImage = Filters.originalImage
//        blurredBackgroundImage = Filters.blackAndWhite(image: Filters.originalImage, completion: { (blurredBackgroundImage) in
//            superView.image = blurredBackgroundImage
//        })
        
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

extension HomeVC: FiltersPreviewControllerDelegate {
    func filterPreviewController(selected: UIImage) {
        self.dismiss(animated: true, completion: nil)
        self.imageView.image = selected
    }
}

extension HomeVC: GalleryViewControllerDelegate {
    func galleryViewController(selected: UIImage) {
        self.imageView.image = selected
        self.tabBarController?.selectedViewController = self
    }
}











//        let actionSheet = UIAlertController(title: "Filters", message: "Choose as filter", preferredStyle: .actionSheet)
//
//        let resetAction = UIAlertAction(title: "Reset", style: .destructive) { (action) in
//            self.imageView.image = Filters.shared.originalImage
//        }
//
//        let bwAction = UIAlertAction(title: "Black & White", style: .default) { (action) in
//            Filters.blackAndWhite(image: image, completion: { (filteredImage) in
//                self.imageView.image = filteredImage
//            })
//        }
//
//        let vintageAction = UIAlertAction(title: "Vintage", style: .default) { (action) in
//            Filters.vintage(image: image, completion: { (filteredImage) in
//                self.imageView.image = filteredImage
//            })
//        }
//
//        let chromeAction = UIAlertAction(title: "Chrome", style: .default) { (action) in
//            Filters.chrome(image: image, completion: { (filteredImage) in
//                self.imageView.image = filteredImage
//            })
//        }
//
//        let fadeAction = UIAlertAction(title: "Fade", style: .default) { (action) in
//            Filters.fade(image: image, completion: { (filteredImage) in
//                self.imageView.image = filteredImage
//            })
//        }
//
//        let instantAction = UIAlertAction(title: "Instant", style: .default) { (action) in
//            Filters.instant(image: image, completion: { (filteredImage) in
//                self.imageView.image = filteredImage
//            })
//        }
//
////        let blurAction = UIAlertAction(title: "Blur", style: .default) { (action) in
////            Filters.blur(image: image, completion: { (filteredImage) in
////                self.imageView.image = filteredImage
////            })
////        }
//
//        actionSheet.addAction(bwAction)
//        actionSheet.addAction(vintageAction)
//        actionSheet.addAction(chromeAction)
//        actionSheet.addAction(fadeAction)
//        actionSheet.addAction(instantAction)
//        actionSheet.addAction(resetAction)
//        //actionSheet.addAction(blurAction)
//
//        self.present(actionSheet, animated: true, completion: nil)
