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
    
    static let shared = Filters()
    
    static var originalImage = UIImage()
    
    let context: CIContext!
    
    let possibleFilters = ["Sepia": "CISepiaTone", "Monochrome": "CIPhotoEffectMono", "Chrome": "CIPhotoEffectChrome", "Inverted": "CIColorInvert", "Vintage": "CIPhotoEffectInstant"]
    
    private init(){
        // Code to create GPU context
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eaglContext = EAGLContext(api: .openGLES2)
        self.context = CIContext(eaglContext: eaglContext!, options: options)
    }
    
    // accessor methods will use this to use specific filters.
    private func filter(name: String, image: UIImage, completion: @escaping filterCompletion) {
        
        OperationQueue().addOperation {
            
            // check to make sure filter exists.
            guard let filter = CIFilter(name: name) else { fatalError("Check spelling of filter name.") }
            // create new CIImage
            let ciImage = CIImage(image: image)
            filter.setValue(ciImage, forKey: kCIInputImageKey)
            
            // get ref to output image that comes out of the filter, or errors out.
            guard let outputImage = filter.outputImage else { fatalError("Error retrieving output image from filter.") }
            
            // create CGImage based on the output image - from filter, onto the context.
            guard let cgImage = self.context.createCGImage(outputImage, from: outputImage.extent) else { fatalError("Error creating CGImage on GPU Context.") }
        
            // add the completion back onto the main queue.
            OperationQueue.main.addOperation {
                completion(UIImage(cgImage: cgImage))
            }
        }
    }
    
    func sepia(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CISepiaTone", image: image, completion: completion)
    }
    
    func blackAndWhite(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func chrome(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    func invert(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CIColorInvert", image: image, completion: completion)
    }
    
    func vintage(image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: "CIPhotoEffectInstant", image: image, completion: completion)
    }
    
//    // possible solution for making more DRY 
    func applyFilter(usingFilterTitled: String, image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: usingFilterTitled, image: image, completion: completion)
    }
    
}
