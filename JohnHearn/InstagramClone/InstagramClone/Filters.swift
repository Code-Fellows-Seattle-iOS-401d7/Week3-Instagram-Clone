//
//  Filters.swift
//  InstagramClone
//
//  Created by John D Hearn on 10/25/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

typealias FilterCompletion = (UIImage?)->()

class Filters{

    // We're a singleton
    static let shared = Filters()
    private init(){}


    //static var originalImage = UIImage()
    static var imageHistory = [UIImage]()
    private static let context = CIContext(eaglContext: EAGLContext(api: .openGLES2)!,
                                           options: [kCIContextWorkingColorSpace: NSNull()])
    private class func filter(name: String,
                              image: UIImage,
                              completion: @escaping FilterCompletion ) {

        OperationQueue().addOperation {
            guard let ciFilter = CIFilter(name: name)
                else { fatalError("Check spelling of filter name.") }
            let ciImage = CIImage(image: image)
            ciFilter.setValue(ciImage, forKey: kCIInputImageKey)

            guard let outputImage = ciFilter.outputImage
                else { fatalError("Error retreiving output image from filter.") }
            guard let cgImage = self.context.createCGImage(outputImage, from: outputImage.extent)
                else { fatalError("Error creating CGImage on GPU Context.") }

            OperationQueue.main.addOperation {
                let filteredImage = UIImage(cgImage: cgImage)
                imageHistory.append(filteredImage)
                completion(filteredImage)
            }
        }
    }

    class func vintage(_ image: UIImage, _ completion: @escaping FilterCompletion ){
        self.filter(name: "CIPhotoEffectTransfer", image: image, completion: completion)
    }
    class func blackAndWhite(_ image: UIImage, _ completion: @escaping FilterCompletion ){
        self.filter(name: "CIPhotoEffectMono", image: image, completion: completion)
    }
    class func chrome(_ image: UIImage, _ completion: @escaping FilterCompletion ){
        self.filter(name: "CIPhotoEffectChrome", image: image, completion: completion)
    }
    class func polaroid(_ image: UIImage, _ completion: @escaping FilterCompletion ){
        self.filter(name: "CIPhotoEffectInstant", image: image, completion: completion)
    }
    class func cool(_ image: UIImage, _ completion: @escaping FilterCompletion ){
        self.filter(name: "CIPhotoEffectProcess", image: image, completion: completion)
    }

}
