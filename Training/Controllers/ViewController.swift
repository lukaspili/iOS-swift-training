//
//  ViewController.swift
//  Training
//
//  Created by Lukasz on 15/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTapOutside))
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("didTapOutside"))
        view.addGestureRecognizer(tapGesture)
        
        let labelTapGesture = UITapGestureRecognizer(target: self, action: Selector("didTapLabel"))
        label.addGestureRecognizer(labelTapGesture)
        label.userInteractionEnabled = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didButtonTouch(sender: AnyObject) {
        performSegueWithIdentifier("show_screen2", sender: self)
    }
    
    func didTapOutside() {
        nameTextField.resignFirstResponder()
    }
    
    func didTapLabel() {
        performSegueWithIdentifier("show_screen2", sender: self)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "show_screen2") {
            let vc = segue.destinationViewController as! Screen2Controller
//            vc.titleToShow = nameTextField.text!
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}

