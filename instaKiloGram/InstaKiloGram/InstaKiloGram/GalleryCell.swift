//
//  GalleryCell.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/26/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    var post: Post? { // property observer(not computed property, because does not return anything)
        didSet { // when post gets set...
            self.cellImageView.image = post?.image
        }
    }
    
    //clear out before comes back on screen
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.cellImageView.image = nil
    }
}


extension GalleryCell {
    
    class func identifier() -> String {
        return String(describing: self) //stringify the identifier
    }
}
