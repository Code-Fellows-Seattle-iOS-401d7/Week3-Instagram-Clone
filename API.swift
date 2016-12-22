//
//  API.swift
//  IGClone
//
//  Created by Corey Malek on 10/24/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import UIKit
import CloudKit                             // our CloudKit database is a SQL database under the hood


typealias PostCompletion = (Bool) -> ()
typealias GetPostsCompletion = ([Post]?) -> ()

class API {
    
    static let shared = API()                                      // static let makes this singleton
    
    let container: CKContainer
    let database: CKDatabase
    
    private init() {                                        // private init makes this TRUE singleton
        
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase                      // find this in docs
    }
    
    
    
    func save(post: Post, completion: @escaping PostCompletion) {
        
        do {
            
            if let record = try Post.recordFor(post: post) {
                self.database.save(record, completionHandler: { (record, error) in
                    if error == nil && record != nil {
                        print("Success saving \(record!)")
                        completion(true)
                    }
                
                })
                
            }
        } catch {
            
            print(error)
            completion(false)
        }
    
    }
    
    
    func getPosts(completion: @escaping GetPostsCompletion) {
        
        let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))
        
        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if error == nil {
                if let records = records {
                    var posts = [Post]()
                    
                    for record in records {
                        guard let asset = record["image"] as? CKAsset else { return }
                        
                        let path = asset.fileURL.path
                        
                        guard let image = UIImage(contentsOfFile: path) else { return }
                        
                        
                        let newPost = Post(image: image)
                        posts.append(newPost)
                        
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
    
}





















































































