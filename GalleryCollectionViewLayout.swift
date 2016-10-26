//
//  GalleryCollectionViewLayout.swift
//  IGClone
//
//  Created by Corey Malek on 10/26/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit

class GalleryCollectionViewLayout: UICollectionViewFlowLayout {
    
    var columns: Int
    let spacing: CGFloat = 1.0
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    var itemWidth: CGFloat {
        let availableWidth = screenWidth - (CGFloat(columns) * spacing)
        return availableWidth / CGFloat(columns)
    }
    
    init(columns: Int) {
        self.columns = columns
        
        super.init()
        
        self.minimumLineSpacing = spacing
        self.minimumInteritemSpacing = spacing
        
        self.scrollDirection = .vertical
        
        self.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}





