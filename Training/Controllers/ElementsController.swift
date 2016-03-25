//
//  ElementsController.swift
//  Training
//
//  Created by Lukasz on 17/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class ElementsController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var elements: [Element] = []
    private var selectedElement: Element?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    // MARK: UITableViewDataSource + UITableViewDelegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let element = elements[indexPath.row]
        
        cell.textLabel!.text = element.name
        
        return cell
    }
    
    // ELEMENT DID SELECT
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
//        if(element.type == .TypeOne) {
//            textField1.text = element.name
//        } else {
//            textField2.text = element.name
//        }
        
        let element = elements[indexPath.row]
        selectedElement = element
        performSegueWithIdentifier("show_element", sender: self)
    }
    
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if(textField.text!.characters.count == 0) {
            return true
        }
        
        let text: String
        let type: ElementType
        if(textField.tag == 1) {
            text = "From 1 = \(textField.text!)"
            type = ElementType.TypeOne
        } else {
            text = "From 2 = \(textField.text!)"
            type = ElementType.TypeTwo
        }
        
        if(selectedElement == nil) {
            let element = Element(name: text, type: type)
            elements.append(element)
        } else {
            selectedElement!.name = text
        }
        
        tableView.reloadData()
        
        textField.text = ""
        selectedElement = nil
        
        return true
    }
    
    
    
    // MARK: Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "show_element") {
            let vc = segue.destinationViewController as! Screen2Controller
            vc.titleToShow = selectedElement!.name
        }
    }
}









