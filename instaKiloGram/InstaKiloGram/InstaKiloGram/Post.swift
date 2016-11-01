//
//  Post.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/25/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit
import CloudKit


enum PostError: Error {
    case writingImageToData
    case writingDataToDisk
}


class Post {
    
    let image: UIImage
    
    init(image: UIImage = UIImage()) {
        self.image = image
    }
}


extension Post {
    // take in post and change it into a CKRecord
    class func recordFor(post: Post) throws -> CKRecord? {
        
        let imageURL = URL.imageURL()
        
        guard let data = UIImageJPEGRepresentation(post.image, 1.0) else { throw PostError.writingImageToData } //taking image and writing data out of it
        
        do {
            try data.write(to: imageURL)
            
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: String(describing: self)) // could also type "Post" instead of String(describing: self)
            
            record.setObject(asset, forKey: "image")
            
            return record
            
        } catch {
            throw PostError.writingDataToDisk
        }
    }
            
}
