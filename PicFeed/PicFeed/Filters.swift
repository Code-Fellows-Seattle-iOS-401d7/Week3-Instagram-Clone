//
//  Filters.swift
//  PicFeed
//
//  Created by Filiz Kurban on 10/25/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit


typealias FilterCompletion = (UIImage?) -> ()

class Filters {

    static let shared = Filters()

    var originalImage = UIImage()

    var availableFilters = ["Vintage" : "CIPhotoEffectTransfer", "BlackAndWhite" : "CIPhotoEffectTonal", "Fade" : "CIPhotoEffectFade", "Chromatic" : "CIPhotoEffectChrome", "Process" : "CIPhotoEffectProcess"]

    //not thread safe so we're creating our own operation queue
    private func filter(name: String, image: UIImage, completion: @escaping FilterCompletion) {
        OperationQueue().addOperation {
            guard let filter = CIFilter(name:name) else { fatalError("") }
            let ciImage = CIImage(image:image)
            filter.setValue(ciImage, forKey: kCIInputImageKey)

            //create GPU context
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let eaglContext = EAGLContext(api: .openGLES2)
            let context = CIContext(eaglContext: eaglContext!, options: options)

            guard let outputImage = filter.outputImage else { fatalError("") }

            //extent : output images frame
            guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { fatalError("") }

            OperationQueue.main.addOperation {
                completion(UIImage(cgImage: cgImage))
            }
        }
    }

    func applyFilter(filterName: String, image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: filterName, image: image, completion: completion)
    }

    func original(filterName: String = "", image: UIImage, completion: @escaping FilterCompletion) {
        completion(Filters.shared.originalImage)
    }
}
