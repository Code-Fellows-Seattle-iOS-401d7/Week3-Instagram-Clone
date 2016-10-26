//
//  GalleryViewController.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/26/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit


class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var allPosts = [Post]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 1)
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
    
}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }
    
    // dequeues cell and preps for new view, then assigns a post to to the new cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier(), for: indexPath) as! GalleryCell
        
        postCell.post = allPosts[indexPath.row]
        
        return postCell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
}


