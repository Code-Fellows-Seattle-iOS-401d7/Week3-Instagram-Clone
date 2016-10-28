//
//  GalleryViewController.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/26/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit

protocol GalleryViewControllerDelegate: class {
    func galleryViewController(selected: UIImage)
}


class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: GalleryViewControllerDelegate?
    
    var allPosts = [Post]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 3)
        self.collectionView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        API.shared.getPosts { (posts) in
            if let posts = posts {
                self.allPosts = posts
            }
        }
    }
   
    @IBAction func userPinched(_ sender: UIPinchGestureRecognizer) {
        
        guard let layout = self.collectionView.collectionViewLayout as? GalleryCollectionViewLayout else { return }
        
        switch sender.state {
        case .ended:
            let columns = sender.velocity > 0 ? layout.columns - 1 : layout.columns + 1
            
//            let maxColumns = allPosts.count
            
            if columns < 1 || columns > 10 {
                return
            }
            
            UIView.animate(withDuration: 0.25, animations: {
                let newLayout = GalleryCollectionViewLayout(columns: columns)
                self.collectionView.setCollectionViewLayout(newLayout, animated: true)
            })
        default:
            return
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    // dequeues cell and preps for new view, then assigns a post to to the new cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier, for: indexPath) as! GalleryCell
        
        postCell.post = allPosts[indexPath.row]
        
        return postCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        
        let selectedCell = self.collectionView.cellForItem(at: indexPath) as! GalleryCell
        
        let selectedImage = selectedCell.post?.image
        
        delegate.galleryViewController(selected: selectedImage!)
        
    }
}






