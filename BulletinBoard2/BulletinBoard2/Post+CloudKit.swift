//
//  Post+CloudKit.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 4/25/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CloudKit

extension Post {
    
    //CKRecord is a key-value pair, so we want keys to be able to access the values.
    static var BodyKey: String { return "Body" }
    static var DateKey: String { return "Date" }
    static var RecordType: String { return "Post" }
     
    // Create a Post from a CKRecord
    
    
    // Create a CKRecord from a post
    init?(cloudKitRecord: CKRecord) {
//        guard let body = cloudKitRecord[Post.BodyKey] as? String,
//            let data = cloudKitRecord[Post.DateKey] as? Date else { return }
        //Can do either way, it's the same thing!
        guard let body = cloudKitRecord.object(forKey: Post.BodyKey) as? String,
            let date = cloudKitRecord.object(forKey: Post.DateKey) as? Date,
            cloudKitRecord.recordType == Post.RecordType else { return nil }
        
        self.body = body
        self.date = date
    
    }
    
    
    
    // CloudKit representation
    
    var cloudKitRecord: CKRecord {
        let record = CKRecord(recordType: Post.RecordType)
        //        record[Post.BodyKey] = body as CKRecordValue
        //^^ Does the same thing as setObject
        record.setObject(body as CKRecordValue, forKey: Post.BodyKey)
        record.setObject(date as CKRecordValue, forKey: Post.DateKey)
        return record
    }
    
}
