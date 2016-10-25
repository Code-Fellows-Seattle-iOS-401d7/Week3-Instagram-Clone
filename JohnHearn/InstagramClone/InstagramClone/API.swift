//
//  API.swift
//  InstagramClone
//
//  Created by John D Hearn on 10/24/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import Foundation
import CloudKit

typealias postCompletion = (Bool)->()

class API {
    static let shared = API()
    let container: CKContainer
    let database: CKDatabase

    private init() {
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase
    }

    func save(post: Post, completion: @escaping postCompletion){
        do{
            if let record = try Post.recordFor(post){
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
