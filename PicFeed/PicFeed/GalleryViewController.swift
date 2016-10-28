//
//  GalleryViewController.swift
//  PicFeed
//
//  Created by Filiz Kurban on 10/26/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, knowsIdentifier {

    @IBOutlet weak var collectionView: UICollectionView!

    var allPosts = [Post]() {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = GalleryCollectionViewFlowLayout(colums: 3)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        API.shared.getPosts { (posts) in
            if let posts = posts {
                self.allPosts = posts
            }
        }
    }

    //passing sender as UIPinchGestureRecognizer as we need state information
    @IBAction func userPinched(_ sender: UIPinchGestureRecognizer) {
        guard let layout = self.collectionView.collectionViewLayout as? GalleryCollectionViewFlowLayout else {return }

        switch sender.state {
        case .ended:
            let columns = sender.velocity > 0 ? layout.colums - 1 : layout.colums + 1

            if columns < 1 || columns > 10 {
                return
            }

            UIView.animate(withDuration: 0.25, animations: {
                let newLayout = GalleryCollectionViewFlowLayout(colums: columns)
                //calls invalidate call under the hood
                self.collectionView.setCollectionViewLayout(newLayout, animated: true)

            })
        default:
            print("Hit default case")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.identifier(), for: indexPath) as! GalleryCell

        postCell.post = allPosts[indexPath.row]

        return postCell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPosts.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tabBarVCs = self.tabBarController?.viewControllers
        let homeVC = tabBarVCs![0] as! HomeViewController
        homeVC.imageView.image = allPosts[indexPath.row].image

        tabBarController?.selectedIndex = 0
    }
}


