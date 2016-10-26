//
//  GalleryViewController.swift
//  IGClone
//
//  Created by Corey Malek on 10/26/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
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
        
        collectionView.dataSource = self
        collectionView.collectionViewLayout = GalleryCollectionViewLayout(columns: 3)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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


extension GalleryViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier(), for: indexPath) as! GalleryCell
        
        postCell.post = allPosts[indexPath.row]
        
        return postCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }
    
}














































