//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by John D Hearn on 10/24/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        presentImagePicker(sourceType: .photoLibrary)

    }

    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {

        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)

    }

}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {




}
