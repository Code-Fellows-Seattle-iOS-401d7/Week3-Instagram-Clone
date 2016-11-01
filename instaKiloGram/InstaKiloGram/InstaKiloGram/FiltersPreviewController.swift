//
//  FiltersPreviewController.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/27/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

// custom protocol
protocol FiltersPreviewControllerDelegate: class {
    func filterPreviewController(selected: UIImage)
}

class FiltersPreviewController: UIViewController {
    
    weak var delegate: FiltersPreviewControllerDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    
    let availableFilters = [Filters.shared.original, Filters.shared.blackAndWhite, Filters.shared.chrome, Filters.shared.vintage, Filters.shared.fade, Filters.shared.instant]
    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCollectionViewFlowLayout(columns: 2)
    }
}

extension FiltersPreviewController {
    static var identifier: String {
        return String(describing: self)
    }
}


extension FiltersPreviewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier(), for: indexPath) as! GalleryCell
        
        let filter = self.availableFilters[indexPath.row]
        
        filter(self.post.image) { (filteredImage) in
            filterCell.cellImageView.image = filteredImage //filteredImage and apply it to filterCell
        }
        return filterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return availableFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        
        let filter = self.availableFilters[indexPath.row]
        
        filter(self.post.image) { (filteredImage) in
            if let filteredImage = filteredImage {
                delegate.filterPreviewController(selected: filteredImage)
            }
        }
    }
}











