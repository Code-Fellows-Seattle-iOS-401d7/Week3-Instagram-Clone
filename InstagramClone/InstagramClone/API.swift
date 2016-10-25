//
//  API.swift
//  InstagramClone
//
//  Created by Erica Winberry on 10/24/16.
//  Copyright © 2016 Erica Winberry. All rights reserved.
//

import Foundation
import CloudKit

class API {
    
    static let shared = API()
    
    let container: CKContainer
    let database: CKDatabase
    
    private init(){
    
        self.container = CKContainer.default()
        self.database = self.container.privateCloudDatabase
        
    }
    
    // Will continue building out methods here all week.
    
}
