//
//  API.swift
//  IGClone
//
//  Created by Corey Malek on 10/24/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import Foundation
import CloudKit                             // our CloudKit database is a SQL database under the hood


typealias postCompletion = (Bool) -> ()

class API {
    
    static let shared = API()                                      // static let makes this singleton
    
    let container: CKContainer
    let database: CKDatabase
    
    private init() {                                        // private init makes this TRUE singleton
        
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase                      // find this in docs
    }
    
    
    
    func save(post: Post, completion: @escaping postCompletion) {
        
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
    
}





















































































