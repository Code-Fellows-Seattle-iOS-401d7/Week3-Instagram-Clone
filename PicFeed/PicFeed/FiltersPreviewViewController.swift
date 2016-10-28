//
//  FiltersPreviewViewController.swift
//  PicFeed
//
//  Created by Filiz Kurban on 10/27/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit


//this is just to pass back the image to Home view controller. We could have passed the image through 
// segue just as well. It might also be simpler. 
protocol FiltersPreviewControllerDelegate : class {
    func filtersPreviewController(selected: UIImage)
}


class FiltersPreviewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    weak var delegate: FiltersPreviewControllerDelegate?

    @IBOutlet weak var collectionView: UICollectionView!

    var filters = Array(Filters.shared.availableFilters.keys)
    //filters function array

    var post = Post()

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCollectionViewFlowLayout(colums: 3)

    }

    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        print(FiltersPreviewViewController.identifier())

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier(), for: indexPath) as! GalleryCell

// if we used the function array.
//        let filterFunction = self.filterFunctions[indexPath.row]
//        filter(filter, self.post.image) { (filteredImage) in
//            cell.cellImage.image = filteredImage
//        }

        let filter = Filters.shared.availableFilters[self.filters[indexPath.row]]

        Filters.shared.applyFilter(filterName: filter!, image: self.post.image) { (filteredImage) in
            cell.cellImage.image = filteredImage
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }

        //dictionary look up returns optional. Makes sense: what if we can't find it?
        let filter = Filters.shared.availableFilters[self.filters[indexPath.row]]

//if we had a function array
//        filter(self.post.image) { (filteredImage) in
//            if let filteredImage != nil {
//                delegate.filtersPreviewController(selected: filteredImage)
//            }
//        }

        Filters.shared.applyFilter(filterName: filter!, image: self.post.image) { (filteredImage) in
            if filteredImage != nil {
                delegate.filtersPreviewController(selected: filteredImage!)
            }
        }

    }
}

extension FiltersPreviewViewController {
    class func identifier() -> String {
        return String(describing: self)
    }
}
