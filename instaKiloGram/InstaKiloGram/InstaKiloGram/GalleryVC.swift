//
//  GalleryVC.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/26/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController {

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
    
    @IBAction func imageLongPressed(_ sender: UILongPressGestureRecognizer) {
        //self.performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
    
    var allPosts = [Post]() { // fetch all posts and display on collection view
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
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
