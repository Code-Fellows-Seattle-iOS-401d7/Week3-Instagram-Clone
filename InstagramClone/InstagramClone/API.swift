//
//  API.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/24/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import UIKit
import CloudKit

typealias PostCompletion = (Bool) -> ()
typealias GetPostsCompletion = ([Post]?) -> ()

class API {
    
    static let shared = API()
    
    let container: CKContainer
    let database: CKDatabase
    
    private init(){
    
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase
        
    }
    
    func save(post: Post, completion: @escaping PostCompletion) {
        
        do {
            if let record = try Post.recordFor(post: post) {
                self.database.save(record, completionHandler: { (record, error) in
                    print(error, record)
                    if error == nil && record != nil {
                        print("Success saving \(record!).")
                        OperationQueue.main.addOperation {
                            completion(true)
                        }
                    }
                })
            }
        } catch {
            print(error)
            completion(false)
        }
        
    }
    
    func getPosts(completion: @escaping GetPostsCompletion) {
        
        // more about predicates later on.
        let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))
        
        // performing action on db, inzonewith nil indicates default zone
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if error == nil {
                // unwrap records with if let, stores optional value of records back into records without being an optional if it exists. (Casting optional records into unoptional version of itself.)
                if let records = records {
                    // empty array that the completion will spit out
                    var posts = [Post]()
                    
                    // if the record has an asset, get the asset and the path to the asset. If there is no image key in the asset, will crash the app.
                    for record in records {
                        guard let asset = record["image"] as? CKAsset else { return }
                        let path = asset.fileURL.path
                        
                        // if there is a path to asset, get the image from that path. Guard let causes a crash if there is no image
                        guard let image = UIImage(contentsOfFile: path) else { return }
                        
                        posts.append(Post(image: image))
                        
                        // the last line is the same as: 
                            // let newPost = Post(image: image?)
                            // posts.append(newPost)
                    }
                    
                    OperationQueue.main.addOperation {
                        completion(posts)
                    }
                    
                }
            } else {
                print(error)
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }
            
        }
        
    }
    
    // Will continue building out methods here all week.
    
}
