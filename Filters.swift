//
//  Filters.swift
//  IGClone
//
//  Created by Corey Malek on 10/25/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit

typealias FilterCompletion = (UIImage?) -> ()


    class Filters {
        
    static var originalImage = UIImage()
        
        static let sharedFilters = Filters()
        
    
    private class func filter(name: String, image: UIImage, completion: @escaping FilterCompletion) {
        
        OperationQueue().addOperation {
            
            guard let filter = CIFilter(name: name) else {fatalError("Check Spelling Of Filter Name")}
            let ciImage = CIImage(image: image)
            filter.setValue(ciImage, forKey: kCIInputImageKey) // <- check for keys in this doc
            
            
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let eaglContext = EAGLContext(api: .openGLES2)
            let context = CIContext(eaglContext: eaglContext!, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Error retrieving output image from filter.") }
            
            guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
                else { fatalError("Error creating CGImage on GPU context") }
            
            OperationQueue.main.addOperation {
                completion(UIImage(cgImage: cgImage))
            }
            
        }
        
    }
    
    class func vintage(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIPhotoEffectTransfer", image: image, completion: completion)
        
    }
    
    class func blackAndWhite(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIPhotoEffectMono", image: image, completion: completion)
        
    }
    
    class func chrome(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIPhotoEffectChrome", image: image, completion: completion)
        
    }
    

    class func noir(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIPhotoEffectNoir", image: image, completion: completion)
        
    }
    
    class func colorInvert(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIColorInvert", image: image, completion: completion)
        
    }
//        private init() {}
    
}

