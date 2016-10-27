//
//  FiltersPreviewViewController.swift
//  InstagramClone
//
//  Created by John D Hearn on 10/27/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

protocol FiltersPreviewViewControllerDelegate : class{
    func filtersPreviewViewController(selected: UIImage)
}

class FiltersPreviewViewController: UIViewController {

    weak var delegate: FiltersPreviewViewControllerDelegate?

    @IBOutlet weak var collectionView: UICollectionView!

    let filters = [Filters.original,
                   Filters.vintage,
                   Filters.blackAndWhite,
                   Filters.chrome,
                   Filters.polaroid,
                   Filters.cool]

    var post = Post()


    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 2)
    }

}

extension FiltersPreviewViewController{
    // Why does this give errors?
    // <unknown>:0: error: a declaration cannot be both 'final' and 'dynamic'
    //static let identifier = String(describing: self)

    static var identifier: String{
        return String(describing: self)
    }

}

extension FiltersPreviewViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier,
                                                            for: indexPath) as! GalleryCell

        let filter = self.filters[indexPath.row]

        filter(self.post.image) { (filteredImage) in
            filterCell.cellImageView.image = filteredImage
        }

        return filterCell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }

        let filter = self.filters[indexPath.row]

        filter(self.post.image) { (filteredImage) in
            if let filteredImage = filteredImage{
                delegate.filtersPreviewViewController(selected: filteredImage)
            }
        }

    }
}





