//
//  User.swift
//  CKUsers
//
//  Created by Austin West on 6/5/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    let username: String
    let firstName: String
    let appleUserReference: CKRecord.Reference
    
    //    Constant
    static let userKey = "User"
    static let appleUserReferenceKey = "appleUserReference"
    fileprivate static let usernameKey = "username"
    fileprivate static let firstNameKey = "firsName"
    
    init(username: String, firstName: String, appleUserReference: CKRecord.Reference) {
        self.username = username
        self.firstName = firstName
        self.appleUserReference = appleUserReference
    }
    
    init?(ckRecord: CKRecord) {
        guard let username = ckRecord[User.usernameKey] as? String,
            let firstName = ckRecord[User.firstNameKey] as? String,
            let appleUserReference = ckRecord[User.appleUserReferenceKey] as? CKRecord.Reference
            else { return nil }
        
        self.username = username
        self.firstName = firstName
        self.appleUserReference = appleUserReference
    }
}

extension CKRecord {
    
    convenience init(user: User) {
        
        self.init(recordType: User.userKey)
        
        self.setValue(user.username, forKey: User.usernameKey)
        self.setValue(user.firstName, forKey: User.firstNameKey)
        self.setValue(user.appleUserReference, forKey: User.appleUserReferenceKey)
    }
}
