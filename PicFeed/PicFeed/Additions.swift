//
//  Additions.swift
//  PicFeed
//
//  Created by Filiz Kurban on 10/25/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

// Create an extension on UIImage that resizes an image to specified parameters.
extension UIImage {
    class func resize(image: UIImage, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        image.draw(in: rect) // image will draw itself in this rect of frame. There is a imageContext created and draw knows about it. Draw intrinsicly needs a context.

        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return resizedImage

    }
}

extension URL {
    static func imageURL() -> URL {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError("Error getting documents directory") }

        return documentsDirectory.appendingPathComponent("image")
    }
}

protocol knowsIdentifier {
   // func identifier() -> String
}

extension knowsIdentifier {
    func identifier() -> String {
    return String(describing: self)
    }
}
