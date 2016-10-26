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
            let record = CKRecord(recordType: String(describing: self))

            record.setObject(asset, forKey: "image")

            return record

        } catch {
            throw PostError.writingDataToDisk
        }
    }
}
