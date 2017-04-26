//
//  CloudKitManager.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 4/25/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitManager {
    
    let publicDataBase = CKContainer.default().publicCloudDatabase
    
    // Fetch
    
    func fetchRecords(ofType type: String, sortDescriptors: [NSSortDescriptor]? = nil, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        
        let query = CKQuery(recordType: type, predicate: NSPredicate(value: true))
        query.sortDescriptors = sortDescriptors
        
        publicDataBase.perform(query, inZoneWith: nil, completionHandler: completion)
        
    }
    
    
    // Save
    
    func save(_ record: CKRecord, completion: @escaping (Error?) -> Void) {

        self.publicDataBase.save(record) { (record, error) in
            completion(error)
        }
    }
    
    // Subscribe
    
    func subscribeToCreationOfRecords(ofType type: String, completion: @escaping ((Error?) -> Void) = { _ in }) {
        let predicate = NSPredicate(value: true)
        let subscription = CKQuerySubscription(recordType: type, predicate: predicate, options: .firesOnRecordCreation)
        
        let notificationInfo = CKNotificationInfo()
        notificationInfo.alertBody = "There's a new message on the bulletin board."
        notificationInfo.shouldBadge = true
        subscription.notificationInfo = notificationInfo
        
        publicDataBase.save(subscription) { (subscription, error) in
            if let error = error {
                NSLog("error saving subscription: \(error)")
            }
            completion(error)
        }
    }
}





























