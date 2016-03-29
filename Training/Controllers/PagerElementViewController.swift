//
//  PagerElementViewController.swift
//  Training
//
//  Created by Lukasz on 29/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class PagerElementViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    
    var name: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = name
    }

}
