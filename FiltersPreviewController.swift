//
//  FiltersPreviewController.swift
//  IGClone
//
//  Created by Corey Malek on 10/27/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit


protocol FiltersPreviewControllerDelegate : class {
    
    func filtersPreviewController(selected: UIImage)
    
}



class FiltersPreviewController: UIViewController {
    
    
   weak var delegate : FiltersPreviewControllerDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let filters = [Filters.original, Filters.blackAndWhite, Filters.chrome, Filters.vintage, Filters.colorInvert, Filters.noir]
    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 2)

    }

}




extension FiltersPreviewController {
   static var identifier: String {
        return String(describing: self)
    }
}




extension FiltersPreviewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // this function is taking the filtered image and posting it to the gallery
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier(), for: indexPath) as! GalleryCell
        
        let filter = self.filters[indexPath.row]
        
        filter(self.post.image) {(filteredImage) in
            filterCell.cellImage.image = filteredImage
        }
        
        return filterCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    // this function is applying the selected filtered image to the home view
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        
        let filter = self.filters[indexPath.row]
        
        filter(self.post.image) { (filteredImage) in
            if let filteredImage = filteredImage {
                delegate.filtersPreviewController(selected: filteredImage)
            }
        }
        
    }
    
}
















