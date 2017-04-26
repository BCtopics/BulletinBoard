//
//  PostListTableViewController.swift
//  BulletinBoard2
//
//  Created by Bradley GIlmore on 4/25/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    
    
    //MARK: - IBActions
    
    // Want to have a Post button that saves the records
    @IBAction func postButtonTapped(_ sender: Any) {
        guard let body = textField.text, !body.isEmpty else { return }
        textField.resignFirstResponder()
        textField.text = ""
        PostController.shared.post(body: body) { error in
            if error == nil {
                self.handleRefresh()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(handleRefresh),
                       name: PostController.DidRefreshNotification,
                       object: nil)
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.doesRelativeDateFormatting = true
        formatter.timeStyle = .short
        return formatter
    }()

    
    func handleRefresh(){
        tableView.reloadData()
    }
    
}


//MARK: - UITableView DataSource

extension PostListTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostController.shared.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        let post = PostController.shared.posts[indexPath.row]
        
        cell.textLabel?.text = post.body
        cell.detailTextLabel?.text = dateFormatter.string(from: post.date)
        
        return cell
    }
    
    
    
}
