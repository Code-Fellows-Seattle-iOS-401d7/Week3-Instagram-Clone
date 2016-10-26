//
//  HomeViewController.swift
//  PicFeed
//
//  Created by Filiz Kurban on 10/24/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    var imagePicker = UIImagePickerController()

    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var filterButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var resetButtonTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var imageView: UIImageView!

    var imageFilterHistory = [UIImage]()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        presentImagePicker(sourceType: .photoLibrary)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        postButtonBottomConstraint.constant = 100
        filterButtonTopConstraint.constant = 100
        resetButtonTopConstraint.constant = 100

        self.view.layoutIfNeeded()

        postButtonBottomConstraint.constant = 32
        filterButtonTopConstraint.constant = 20
        resetButtonTopConstraint.constant = 20

        UIView.animate(withDuration: 1.0) {
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
        let actionSheet = UIAlertController(title: "Source", message: "Please select source type", preferredStyle: .actionSheet)

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

        self.present(actionSheet, animated:true, completion: nil)

    }

    @IBAction func resetButtonPressed(_ sender: AnyObject) {
        if imageFilterHistory.count > 0 {
            self.imageView.image = imageFilterHistory.popLast()
        } else {
            self.resetButton.setTitle("Original Image", for: .normal)

        }
    }

    func filterAction(actionName: String) {
        guard let image = self.imageView.image else { return  }

        if Filters.shared.availableFilters.keys.contains(actionName) {
            let filter = Filters.shared.availableFilters[actionName]
            Filters.applyFilter(filterName: filter!, image: image) { (filteredImage) in
                let tempImg = self.imageView.image
                self.imageFilterHistory.append(tempImg!)
                self.imageView.image = filteredImage
                self.resetButton.setTitle("Undo", for: UIControlState.normal)
            }
        }
    }

    @IBAction func filterButtonPressed(_ sender: AnyObject) {

        let actionSheet = UIAlertController(title: "Filters", message: "Please pick a filter:", preferredStyle: .actionSheet)

        for eachFilter in Filters.shared.availableFilters {
            let title = eachFilter.key
            let action = UIAlertAction(title: title, style: .default, handler: { (action) in self.filterAction(actionName: title) })
            actionSheet.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true)
    }

    @IBAction func imageTapped(_ sender: AnyObject) {
        presentActionSheet()
    }

    @IBAction func postButtonPressed(_ sender: AnyObject) {
        if let image = imageView.image {
            let newPost = Post(image: image)

            API.shared.save(post: newPost, completion: { (success) in
                print("New post was saved to CloudKit")
                //below selector function image is specifically asked by UIImageWriteToSavedPhotosAlbum. Otherwise it could have been
                //just saveImage() function.
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(HomeViewController.image(_:didFinishSaving:context:)), nil)
            })
        }
    }

    func image(_ image: UIImage, didFinishSaving error: NSError?, context: UnsafeRawPointer) {
        if error == nil {
            let alert = UIAlertController(title: "Saved", message: "Your image was saved to your photos", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageView.image = editedImage
            Filters.shared.originalImage = editedImage
        }

        self.dismiss(animated: true, completion: nil)
    }
}
