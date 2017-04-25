//
//  PostController.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 4/25/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation
import CloudKit

class PostController {
    
    static let shared = PostController()
    
    private let cloudKitManager = CloudKitManager()

    var posts = [Post]() {
        didSet{
            //Update
        }
    }
    
    
    //Add Posts (Create)
    // Take a completion closure so that we can be notified at the call site when our post method finishes running. 
    //Our completion takes a default value of an empty closure so that we can call post in instances where we don't
    //  care if it has completed.
    // When we do care about the completion of the method. We can pass in our own closure and check for the error paramater to see if an error has occured and display a message or print to the console accordingly.
    // If our completion took in ((CKRecord?, Error?) -> Void) then our default value would be { _, _ in }
    func post(body: String, completion: @escaping ((Error?) -> Void) = { _ in }) {
    // Create a Post
        let post = Post(body: body)
    // Save : Saving will check if an error occurs. If an error occurs we don't want to append the post.
        // CloudKitManager.save method takes in a closure with a parameter of type Error? and will tell us if the save has failed. We call post completion with the error paramater so that when you cll it in our viewcontroller we can have 
        // access to the error that the cloudKitManager.save threw. Since we are calling the completion in the cloudKitManager.save closure we have to make the post completion @escaping.
        cloudKitManager.save(post.cloudKitRecord) { (error) in
            defer { completion(error) }
            
            if let error = error {
                NSLog("Erorr saving post: \(error)")
                return
            }
            // Append Post to the posts array
            self.posts.append(post)
        }
    }
    
    
    
    // Fetch Posts (Retrive)
    
    func fetch(completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let sortDescriptors = [NSSortDescriptor(key: Post.DateKey, ascending: false)]
        
        cloudKitManager.fetchRecords(ofType: Post.RecordType, sortDescriptors: sortDescriptors) { (records, error) in
    defer { completion(error) }
    
            if let error = error {
                NSLog("Error fetching post: \(error)")
                return
            }
            
            guard let records = records else { return }
            
            self.posts = records.flatMap { Post(cloudKitRecord: $0) }
            
        }
    }
}


















