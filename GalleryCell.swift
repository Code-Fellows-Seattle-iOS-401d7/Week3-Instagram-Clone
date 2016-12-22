//
//  GalleryCell.swift
//  IGClone
//
//  Created by Corey Malek on 10/26/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    
    
    var post : Post? {
        didSet {
            self.cellImage.image = post?.image
        }
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.cellImage.image = nil
    }
    
}


extension GalleryCell {
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
}
