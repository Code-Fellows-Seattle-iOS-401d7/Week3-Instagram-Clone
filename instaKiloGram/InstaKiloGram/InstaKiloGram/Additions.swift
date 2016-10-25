//
//  Additions.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/25/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit


extension UIImage {
    class func resize(image: UIImage, size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        
        image.draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage!
    }
}


extension URL {
    static func imageURL() -> URL {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Error getting documents directory.")
        }
        return documentsDirectory.appendingPathComponent("image")
    }
}
