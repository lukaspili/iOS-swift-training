//
//  ElementsController.swift
//  Training
//
//  Created by Lukasz on 17/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class ElementsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("row = \(indexPath.row)")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        cell.textLabel!.text = "Row \(indexPath.row)"
        
        return cell
    }
}









