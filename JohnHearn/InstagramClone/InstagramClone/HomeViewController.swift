//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by John D Hearn on 10/24/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var imagePickerView: UIImageView!

    @IBOutlet weak var filterButtonTopConstraingt: NSLayoutConstraint!
    @IBOutlet weak var postButtonBottomConstraint: NSLayoutConstraint!
    

    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        presentImagePicker(sourceType: .photoLibrary)

        // We move these so they animates the first time viewDidAppear()
        postButtonBottomConstraint.constant = 100
        filterButtonTopConstraingt.constant = 100
        self.view.layoutIfNeeded()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        postButtonBottomConstraint.constant = 8
        filterButtonTopConstraingt.constant = 8
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
        let actionSheet = UIAlertController(title: "Source",
                                            message: "Please Select Source Type:",
                                            preferredStyle: .actionSheet)

        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default) { (action) in
            self.presentImagePicker(sourceType: .camera)
        }

        let photoLibraryAction = UIAlertAction(title: "Photo Library",
                                               style: .default) { (action) in
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
        if let image = imagePickerView.image{
            let newPost = Post(image: image)

            API.shared.save(post: newPost, completion: {(success) in
                if success{
                    print("New Post was saved to CloudKit.")

                    let selector = #selector(HomeViewController.image(_: didFinishSaving: context: ))

                    UIImageWriteToSavedPhotosAlbum(image, self, selector, nil)
                }
            })
        }
    }
    
    @IBAction func filterButtonPressed(_ sender: AnyObject) {

        typealias FilterFunction = ( _:UIImage, _: @escaping (UIImage?)->() )->()

        guard let image = self.imagePickerView.image else { return }  // do nothing if we don't have an image yet

        func filterActionMaker(_ title: String, _ filter: @escaping FilterFunction ) -> UIAlertAction?{
            let filterAction = UIAlertAction(title: title, style: .default) { (action) in
                filter(image, { (filteredImage) in
                    self.imagePickerView.image = filteredImage
                })
            }
            return filterAction
        }

        let actionSheet = UIAlertController(title: "Filters", message: "Please pick a filter:", preferredStyle: .actionSheet)

        let vintageAction  = filterActionMaker( "Vintage", Filters.vintage )
        let bwAction       = filterActionMaker( "Black & White", Filters.blackAndWhite )
        let chromeAction   = filterActionMaker( "Chrome", Filters.chrome )
        let polaroidAction = filterActionMaker( "Polaroid", Filters.polaroid )
        let coolAction     = filterActionMaker( "Cool", Filters.cool )
        let cancelAction   = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(vintageAction!)
        actionSheet.addAction(bwAction!)
        actionSheet.addAction(chromeAction!)
        actionSheet.addAction(polaroidAction!)
        actionSheet.addAction(coolAction!)
        actionSheet.addAction(cancelAction)

        self.present(actionSheet, animated: true, completion: nil)

    }

    func image(_ image: UIImage, didFinishSaving error: NSError?, context: UnsafeRawPointer){
        if error == nil{
            let alert = UIAlertController(title: "Saved.", message: "Your image was saved to your photos.",
                                          preferredStyle: .alert)

            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {


        // Nested if statements so if someone changes self.imagePicker.allowsEditing
        // it won't break
        if self.imagePicker.allowsEditing {
            if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
                self.imagePickerView.image = editedImage
                //Filters.originalImage = editedImage
                Filters.imageHistory.append(editedImage)
            }
        } else {
            if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
                self.imagePickerView.image = originalImage
                //Filters.originalImage = originalImage
                Filters.imageHistory.append(originalImage)

            }
        }

        self.imagePickerControllerDidCancel(imagePicker)
            
    }
}







