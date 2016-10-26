//
//  Filters.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/25/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

typealias filterCompletion = (UIImage?) -> ()


class Filters {
    
    static var originalImage = UIImage()
    
    // accessor methods will use this to use specific filters.
    private class func filter(name: String, image: UIImage, completion: @escaping filterCompletion) {
        
        OperationQueue().addOperation {
            
            // check to make sure filter exists.
            guard let filter = CIFilter(name: name) else { fatalError("Check spelling of filter name.") }
            // create new CIImage
            let ciImage = CIImage(image: image)
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            
            // boilerplate code to create GPU context
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let eaglContext = EAGLContext(api: .openGLES2)
            let context  = CIContext(eaglContext: eaglContext!, options: options)
            
            // get ref to output image that comes out of the filter, or errors out.
            guard let outputImage = filter.outputImage else { fatalError("Error retrieving output image from filter.") }
            
            // create CGImage based on the output image - from filter, onto the context.
            guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { fatalError("Error creating CGImage on GPU Context.") }
        
            // add the completion back onto the main queue.
            OperationQueue.main.addOperation {
                completion(UIImage(cgImage: cgImage))
            }
        }
    }
    
    class func sepia(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CISepiaTone", image: image, completion: completion)
    }
    
    class func blackAndWhite(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    class func invert(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CIColorInvert", image: image, completion: completion)
    }
    
    class func vintage(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CIPhotoEffectInstant", image: image, completion: completion)
    }
    
//    // possible solution for making more DRY - need to put filter names into a dict that holds filter name and string that is the actual name of the filter in the docs
//    class func applyFilter(filterName: String, image: UIImage, completion: @escaping filterCompletion) {
//        self.filter(name: filterName, image: image, completion: completion)
//    }
    
}
