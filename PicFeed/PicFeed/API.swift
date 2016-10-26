//
//  API.swift
//  PicFeed
//
//  Created by Filiz Kurban on 10/24/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import UIKit
import CloudKit


typealias postCompletion = (Bool) -> ()
typealias GetPostsCompletion = ([Post]?) -> ()

enum PostError: Error {
    case writingImageToData
    case writingDataToDisk
}

class API {

    static let shared = API()

    let container:CKContainer
    let database: CKDatabase

    private init() {
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase
    }

    //this func works on the shared instance
    func save(post: Post, completion: @escaping postCompletion) {
        do {
            if let record = try API.recordFor(post: post) {
                self.database.save(record, completionHandler: { (record, error) in
                    if error == nil && record != nil {
                        print("Success saving \(record)")
                        completion(true)
                    }
                })
            }
        } catch {
            print(error)
            completion(false)
        }
    }

    //this is available to the class and does one thing irrespactive of the instance.
    //recordFor returns a record of
    class func recordFor(post: Post) throws -> CKRecord? {
        guard let data = UIImageJPEGRepresentation(post.image, 1.0) else { throw PostError.writingImageToData }

        let imageURL = URL.imageURL()
        do {
            try data.write(to: imageURL)

            //CKAsset represents data: files, text file, image, audio
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: String(describing: Post.identifier())) //

            record.setObject(asset, forKey: "image")

            return record

        } catch {
            throw PostError.writingDataToDisk
        }
    }

    func getPosts(completion: @escaping GetPostsCompletion) {
        let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))

        self.database.perform(query, inZoneWith: nil) { (records, error) in
            if error == nil {
                if let records = records { //records are CKRecords and not Posts
                    var posts = [Post]()

                    for record in records {
                        guard let asset = record["image"] as? CKAsset else { return }
                        let path = asset.fileURL.path

                        guard let image = UIImage(contentsOfFile: path) else { return  }

                        posts.append(Post(image: image))

                        OperationQueue.main.addOperation {
                            completion(posts)
                        }
                    }
                }
            } else {
                print(error?.localizedDescription)
                OperationQueue.main.addOperation {
                    completion(nil)
                }
            }
        }
    }
}
