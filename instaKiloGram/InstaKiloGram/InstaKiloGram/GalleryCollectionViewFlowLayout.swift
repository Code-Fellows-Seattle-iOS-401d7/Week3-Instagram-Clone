//
//  GalleryCollectionViewFlowLayout.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/26/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class GalleryCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var columns: Int
    let spacing: CGFloat = 1.0
    
    var screenWidth: CGFloat {
        return UIScreen.main.bounds.width // represents the screen width
    }
    
    var itemWidth: CGFloat {
        let availableWidth = screenWidth - (CGFloat(self.columns) * spacing) // each item will have 1.0 point spacing b/w them
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
        
        self.itemSize = CGSize(width: itemWidth, height: itemHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
