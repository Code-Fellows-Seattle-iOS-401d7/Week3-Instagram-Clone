//
//  GalleryCell.swift
//  InstagramClone
//
//  Created by John D Hearn on 10/26/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!

    var post : Post? {
        didSet{
            self.cellImageView.image = post?.image
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellImageView.image = nil
    }



}

extension GalleryCell {
    class func identifier() -> String{
        return String(describing: self)
    }
}
