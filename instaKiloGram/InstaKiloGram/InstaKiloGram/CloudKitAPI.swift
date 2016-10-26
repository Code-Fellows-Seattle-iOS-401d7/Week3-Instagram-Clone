//
//  CloudKitAPI.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/24/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import UIKit
import CloudKit


typealias PostCompletion = (Bool) -> ()
typealias GetPostsCompletion = ([Post]?) -> ()

class API {
    
    static let shared = API()
    
    // create reference to cloudKit container
    let container: CKContainer
    
    // create reference to cloudKit db
    let database: CKDatabase
    
    // keep private because inside init, assign the two values and assure that is not rewritten
    private init() {
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase
    }
    
    func save(post: Post, completion: @escaping PostCompletion) {  // let it "escape" the life cycle of func --> referring to saving the record
    
        do {
            if let record = try Post.recordFor(post: post) {
               self.database.save(record, completionHandler: { (record, error) in
                if error == nil && record != nil {
                    print("Success saving \(record!)!")
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
                if let records = records { //casting optional records into unopitonal version of itself
                    var posts = [Post]()
                    
                    for record in records {
                        guard let asset = record["image"] as? CKAsset else { return }
                        
                        let path = asset.fileURL.path
                        
                        guard let image = UIImage(contentsOfFile: path) else { return }
                        
                        posts.append(Post(image: image))
                    }
                    OperationQueue.main.addOperation {
                        completion(posts)
                    }
                }
            } else {
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }
        }
    }
}
