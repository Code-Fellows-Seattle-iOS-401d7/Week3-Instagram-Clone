//
//  GalleryCollectionViewFlowLayout.swift
//  PicFeed
//
//  Created by Filiz Kurban on 10/26/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class GalleryCollectionViewFlowLayout: UICollectionViewFlowLayout {

    var colums: Int
    let spacing: CGFloat = 1.0

    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    var itemWidth: CGFloat {
        let availableWidth = screenWidth - (CGFloat(self.colums) * self.spacing)
        return availableWidth / CGFloat(colums)
    }

    init(colums: Int) {
        self.colums = colums
        super.init()

        self.minimumLineSpacing = spacing
        self.minimumInteritemSpacing = spacing

        self.itemSize = CGSize(width: itemWidth, height: itemWidth)

        self.scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
