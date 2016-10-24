//
//  CloudKitAPI.swift
//  InstaKiloGram
//
//  Created by Jacob Dobson on 10/24/16.
//  Copyright © 2016 Jacob Dobson. All rights reserved.
//

import Foundation
import CloudKit


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
}
