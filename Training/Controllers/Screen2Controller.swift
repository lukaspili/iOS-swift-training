//
//  Screen2Controller.swift
//  Training
//
//  Created by Lukasz on 17/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class Screen2Controller: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleToShow = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(titleToShow.characters.count > 0)
        titleLabel.text = titleToShow
        
        self.title = titleToShow
    }
    
    
    @IBAction func didButtonTouch(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}