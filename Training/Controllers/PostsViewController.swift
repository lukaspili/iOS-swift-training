//
//  PostsViewController.swift
//  Training
//
//  Created by Lukasz on 31/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit
import Alamofire

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    private var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: Selector("didRefresh"), forControlEvents: .ValueChanged)

        startRequest()
    }
    
    private func startRequest() {
        Alamofire.request(.GET, "http://jsonplaceholder.typicode.com/posts").responseJSON { (response) in
            
            self.refreshControl.endRefreshing()
            
            guard let json = response.result.value as? [[String:AnyObject]] else {
                return
            }
            
            self.posts = json
                .map({ (jsonPost: [String:AnyObject]) in
                    return Post(
                        id: jsonPost["id"] as? Int ?? 0,
                        title: jsonPost["title"] as? String ?? "",
                        body: jsonPost["body"] as? String ?? ""
                    )
                })
                .filter({ $0.id > 0 && !$0.title.isEmpty && !$0.body.isEmpty})
            
            
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: Events
    
    func didRefresh() {
        startRequest()
    }

    
    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let post = posts[indexPath.row]
        
        cell.textLabel!.text = post.title
        
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
