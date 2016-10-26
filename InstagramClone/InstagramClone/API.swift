//
//  API.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/24/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import Foundation
import CloudKit

typealias postCompletion = (Bool) -> ()

class API {
    
    static let shared = API()
    
    let container: CKContainer
    let database: CKDatabase
    
    private init(){
    
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase
        
    }
    
    func save(post: Post, completion: @escaping postCompletion) {
        
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
    
    // Will continue building out methods here all week.
    
}
