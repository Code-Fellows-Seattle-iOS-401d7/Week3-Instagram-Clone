//
//  GalleryCollectionViewLayout.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/26/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

class GalleryCollectionViewLayout: UICollectionViewFlowLayout {

    var columns: Int
    let spacing: CGFloat = 1.0
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var itemWidth: CGFloat {
        let availableWidth = screenWidth - (CGFloat(self.columns) * self.spacing)
        return availableWidth / CGFloat(columns)
    }
    
    var itemHeight: CGFloat {
        return itemWidth
    }
    
    init(columns: Int) {
        self.columns = columns
        
        super.init()
        
        self.minimumLineSpacing = spacing
        self.minimumInteritemSpacing = spacing
        
        self.scrollDirection = .horizontal
        
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
