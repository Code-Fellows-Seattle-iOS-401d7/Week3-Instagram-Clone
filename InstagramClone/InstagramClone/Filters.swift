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
    
    // Singleton: make one instance of itself
    static let shared = Filters()
    
    var originalImage = UIImage()
    
    let context: CIContext!
    
    let possibleFilters = ["Sepia": "CISepiaTone", "Monochrome": "CIPhotoEffectMono", "Chrome": "CIPhotoEffectChrome", "Inverted": "CIColorInvert", "Vintage": "CIPhotoEffectInstant"]
    
    // Make it a 'true' singleton
    private init(){
        // Code to create GPU context, in init so only have 1 context
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eaglContext = EAGLContext(api: .openGLES2)
        self.context = CIContext(eaglContext: eaglContext!, options: options)
    }
    
    // accessor methods will use this to use specific filters.
    private func filter(name: String, image: UIImage, completion: @escaping filterCompletion) {
        
        OperationQueue().addOperation {
            
            // check to make sure filter exists, create new instance of filter.
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
    
    func original(image: UIImage, completion: @escaping filterCompletion) {
        completion(Filters.shared.originalImage)
    }
    
    // Making more DRY 
    func applyFilter(usingFilterTitled: String, image: UIImage, completion: @escaping filterCompletion) {
        self.filter(name: usingFilterTitled, image: image, completion: completion)
    }
    
}
