//
//  GalleryVC.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/26/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

protocol GalleryViewControllerDelegate : class{
    func galleryViewController(selected: UIImage)
}

class GalleryVC: UIViewController {
    
    weak var delegate: GalleryViewControllerDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func userPinched(_ sender: UIPinchGestureRecognizer) {
        guard let layout = self.collectionView.collectionViewLayout as? GalleryCollectionViewFlowLayout else { return }
        
        switch sender.state {
        case .ended:
            let columns = sender.velocity > 0 ? layout.columns - 1 : layout.columns + 1
            let maxColumns = allPosts.count > 10 ? 10 : allPosts.count
            if columns < 1 || columns > maxColumns { return }
            UIView.animate(withDuration: 0.25, animations: {
                let newLayout = GalleryCollectionViewFlowLayout(columns: columns)
                self.collectionView.setCollectionViewLayout(newLayout, animated: true)
            })
//        case .changed:
//            
        default:
            return
        }
    }
    
    
    var allPosts = [Post]() { // fetch all posts and display on collection view
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = GalleryCollectionViewFlowLayout(columns: 3)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        API.shared.getPosts { (posts) in
            if let posts = posts {
                self.allPosts = posts
            }
        }
    }
}


extension GalleryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier(), for: indexPath) as! GalleryCell // instance of UICollectionViewCell force as GalleryCell
        
        postCell.post = allPosts[indexPath.row]
        
        return postCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }
}

extension GalleryVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let delegate = self.delegate else { return }
        
        let post = self.allPosts[indexPath.row]
        
        delegate.galleryViewController(selected: post.image)
        }
}
