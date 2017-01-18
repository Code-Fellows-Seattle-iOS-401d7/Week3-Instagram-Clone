//
//  GalleryViewController.swift
//  InstagramClone
//
//  Created by John D Hearn on 10/26/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import UIKit

protocol GalleryViewControllerDelegate : class{
    func galleryViewController(selected: UIImage)
}

class GalleryViewController: UIViewController {

    weak var delegate: GalleryViewControllerDelegate?

    @IBOutlet weak var collectionView: UICollectionView!

    var allPosts = [Post](){
        didSet{
            collectionView.reloadData()
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 2)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        API.shared.getPosts{ (posts) in
            if let posts = posts{
                self.allPosts = posts

            }

        }

    }


    @IBAction func userPinched(_ sender: UIPinchGestureRecognizer) {
        // Only want this to work on our custom layout
        guard let layout = self.collectionView.collectionViewLayout
            as? GalleryCollectionViewLayout else { return }

        switch sender.state {
        case .ended:   // .changed
            let columns = sender.velocity > 0 ? layout.columns-1 : layout.columns+1

            let maxColumns = allPosts.count > 10 ? 10 : allPosts.count
            if columns < 1 || columns > maxColumns { return }

            UIView.animate(withDuration: 0.25, animations: {
                let newLayout = GalleryCollectionViewLayout(columns: columns)
                self.collectionView.setCollectionViewLayout(newLayout, animated: true)
            })
        default:
            return
        }
        
    }



}



extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate  {

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier,
                                                          for: indexPath) as! GalleryCell
        postCell.post = self.allPosts[indexPath.row]

        return postCell

    }

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }

        let post = self.allPosts[indexPath.row]

        delegate.galleryViewController(selected: post.image)

    }

}


