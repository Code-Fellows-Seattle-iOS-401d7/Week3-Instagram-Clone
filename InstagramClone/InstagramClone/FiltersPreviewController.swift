//
//  FiltersPreviewController.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/27/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

protocol FiltersPreviewControllerDelegate: class {
    func filtersPreviewController(selected: UIImage)
}

class FiltersPreviewController: UIViewController {
    
    weak var delegate: FiltersPreviewControllerDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    
    let filterNames = Array(Filters.shared.possibleFilters.values)
    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 2)
    }
}

// MARK: Extensions

extension FiltersPreviewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension FiltersPreviewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
        
        let filterName = self.filterNames[indexPath.row]
        
        Filters.shared.applyFilter(usingFilterTitled: filterName, image: post.image) { (filteredImage) in
            filterCell.cellImageView.image = filteredImage
        }
        
        return filterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        
        let filterName = self.filterNames[indexPath.row]
        
        Filters.shared.applyFilter(usingFilterTitled: filterName, image: post.image) { (filteredImage) in
            if let filteredImage = filteredImage {
                delegate.filtersPreviewController(selected: filteredImage)
            }
        }
    }
}




