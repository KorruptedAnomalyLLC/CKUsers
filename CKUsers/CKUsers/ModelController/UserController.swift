//
//  UserController.swift
//  CKUsers
//
//  Created by Austin West on 6/5/19.
//  Copyright © 2019 Austin West. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
    
    static let shared = UserController()
    var currentUser: User?
    let publicDB = CKContainer.default().publicCloudDatabase
    
    private init() {}
    
    //    CRUD
    
    func  createNewUser(username: String, firstName: String, completion: @escaping (Bool) -> Void) {
        
        CKContainer.default().fetchUserRecordID { (appleUserID, error) in
            if let error = error {
                print("There was and error obtaining the 'Users' recordID for the user: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            //            SSN
            guard let appleUserID = appleUserID else { completion(false) ; return }
            
            let appleUserReference = CKRecord.Reference(recordID: appleUserID, action: .deleteSelf)
            
            let newUser = User(username: username, firstName: firstName, appleUserReference: appleUserReference)
            
            let userRecord = CKRecord(user: newUser)
            
            self.publicDB.save(userRecord, completionHandler: { (_, error) in
                if let error = error {
                    print("There was an error saving to the cloud: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                self.currentUser = newUser
                completion(true)
                
            })
        }
    }
    
    func fetchCurrentUser(completion: @escaping (Bool) -> Void) {
        CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
            if let error = error {
                print("There was and error obtaining the 'Users' recordID for the user: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let appleUserRecordID = appleUserRecordID else {
                completion(false) ; return
            }
            
            let appleUserReference = CKRecord.Reference(recordID: appleUserRecordID, action: .deleteSelf)
            
            let predicate = NSPredicate(format: "%K == %@",
                                        User.appleUserReferenceKey, appleUserReference)
            
            let query = CKQuery(recordType: User.userKey, predicate: predicate)
            
            self.publicDB.perform(query, inZoneWith: nil, completionHandler: {
                (records, error) in
                if let error = error {
                    print("There was and error obtaining the 'Users' recordID for the user: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let records = records,
                records.count == 1,
                    let userRecord = records.first
                    else { completion(false) ; return }
                
                let currentUser = User(ckRecord: userRecord)
                self.currentUser = currentUser
                completion(true)
            })
            
        }
    }
}
