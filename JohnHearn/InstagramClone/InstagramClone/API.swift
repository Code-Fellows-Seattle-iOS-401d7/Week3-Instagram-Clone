//
//  API.swift
//  InstagramClone
//
//  Created by John D Hearn on 10/24/16.
//  Copyright © 2016 Bastardized Productions. All rights reserved.
//

import Foundation
import CloudKit

class API {
    static let shared = API()
    let container: CKContainer
    let database: CKDatabase

    private init() {
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase
    }

}
