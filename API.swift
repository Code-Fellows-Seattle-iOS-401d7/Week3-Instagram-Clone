//
//  API.swift
//  IGClone
//
//  Created by Corey Malek on 10/24/16.
//  Copyright © 2016 Corey Malek. All rights reserved.
//

import Foundation
import CloudKit                             // our CloudKit database is a SQL database under the hood


class API {
    
    static let shared = API()                                      // static let makes this singleton
    
    let container: CKContainer
    let database: CKDatabase
    
    private init() {                                        // private init makes this TRUE singleton
        
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase                      // find this in docs
    }
    
    
    
}
