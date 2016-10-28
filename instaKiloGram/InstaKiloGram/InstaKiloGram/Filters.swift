//
//  Filters.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/25/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit


typealias FilterCompletion = (UIImage?) -> ()

class Filters {
    
    static let shared = Filters()
    
    static var originalImage = UIImage() //use to hold onto original(for undo/reset)
    
    let context : CIContext!
    
    private init() {
        let options = [kCIContextWorkingColorSpace: NSNull()] // next 3 lines of boilerplate to be done on GPU for quicker image processing
        let eagleContext = EAGLContext(api: .openGLES2)
        self.context = CIContext(eaglContext: eagleContext!, options: options)
    }
    
    func filter(name: String, image: UIImage, completion: @escaping FilterCompletion) { //
        OperationQueue().addOperation {
            
            guard let filter = CIFilter(name: name) else { fatalError("check spelling of filter name") } // grab filter
            let coreImage = CIImage(image: image) // new core image
            filter.setValue(coreImage, forKey: kCIInputImageKey) // set value of core image to key given
            
//            let options = [kCIContextWorkingColorSpace: NSNull()] // next 3 lines of boilerplate to be done on GPU for quicker image processing
//            let eagleContext = EAGLContext(api: .openGLES2)
//            let coreImageContext = CIContext(eaglContext: eagleContext!, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("Error retrieveing output image from filter") } // set output image to the core image with filter
            
            guard let coreGraphicsImage = self.context.createCGImage(outputImage, from: outputImage.extent) else { fatalError("Error creating CGImage on GPU context") } // throw filtered image onto the context, draw rect for drawing in
            
            OperationQueue.main.addOperation { // back to main thread
                completion(UIImage(cgImage: coreGraphicsImage))
            }
            
        }
    }
    
    func original(image: UIImage, completion: @escaping FilterCompletion) {
        completion(Filters.originalImage)
    }
    
    func vintage(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    func blackAndWhite(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func chrome(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    func fade(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIPhotoEffectFade", image: image, completion: completion)
    }
    
    func instant(image: UIImage, completion: @escaping FilterCompletion) {
        self.filter(name: "CIPhotoEffectInstant", image: image, completion: completion)
    }
    
//    class func blur(image: UIImage, completion: @escaping FilterCompletion) {
//        self.filter(name: "CIGaussianBlur", image: image, completion: completion)
//    }
}
