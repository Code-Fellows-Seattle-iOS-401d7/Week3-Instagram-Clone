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

    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        presentImagePicker(sourceType: .photoLibrary)

    }

    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {

        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)

    }

    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Source", message: "Please Select Source Type:", preferredStyle: .actionSheet)

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
            }
        } else {
            if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
                self.imagePickerView.image = originalImage

            }
        }

        self.imagePickerControllerDidCancel(imagePicker)
            
    }
}







