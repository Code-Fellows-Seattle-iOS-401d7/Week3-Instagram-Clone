//
//  Additions.swift
//  IGClone
//
//  Created by Corey Malek on 10/25/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func resize(image: UIImage, size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContext(size)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        image.draw(in: rect)
        
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImage
        
    }
    
}

extension URL {
    
    static func imageURL() -> URL {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            else {
                fatalError("Error getting documents directory")
        }
        
        return documentsDirectory.appendingPathComponent("image")
        
    }
    
}





