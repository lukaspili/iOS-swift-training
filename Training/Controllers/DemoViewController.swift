//
//  DemoViewController.swift
//  Training
//
//  Created by Lukasz on 29/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit
import SnapKit

class DemoViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    private var pages = [DemoPageViewController]()
    
    
    
    
    
    func computeLongOperation(completion: (Int) -> (String)) {
        
        print("COMPUTE START")
        
        // LONG COMPUTATION IN ASYNC
        let result = 100
        
        let message = completion(result)
        print(message)
        
        print("COMPUTE END")
    }
    
    func toto() {
        
        print("START")
        
        computeLongOperation { (result) -> (String) in
            return "The result is: \(result)"
        }
        
        print("END")
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self

        addPage(color: UIColor.greenColor())
        addPage(color: UIColor.redColor())
        addPage(color: UIColor.blueColor())
        
        
        // view
        // -- scrollview
        // ----- content view
        // ------- pageview 1
        // ------- pageview 2
        // ------- pageview 3
        
        
        // asd
        // REQUEST -> ALAMOFIRE -> CLOSURE
        // dsf
        // sdfs
        // sdf
        // CLOSURE
        
        
        for (index, controller) in pages.enumerate() {
            // step1: add child controller
            addChildViewController(controller)
            
            // step2: add child view to parent view
            contentView.addSubview(controller.view)
            
            
            var array = [2, 4, 10, 20]
            var array2 = [Int]()
            for item in array {
                array2.append(item * item)
            }
            
            let array3 = array.map({ $0 * $0 })
            
            
            let toto = array.map { "hello = \($0)" }
            
            let names = ["John", "Theo", "Thomas"]
            print("Bonjour ")
            
            // => array2 = [4, 16, 100, 400]
            
            
            
            // step3: constraints
            controller.view.snp_makeConstraints { (make) in
                
                // taille
                make.width.height.equalTo(scrollView)
                
                // position
                if(index == 0) {
                    make.left.equalTo(contentView.snp_left)
                } else {
                    make.left.equalTo(pages[index - 1].view.snp_right)
                }
                
                if(index == pages.count - 1) {
                    make.right.equalTo(contentView.snp_right)
                }
            }
            
            // step 4:
            controller.didMoveToParentViewController(self)
        }
        
        
    }
    
    private func addPage(color color: UIColor) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("DemoPageViewController") as! DemoPageViewController
        vc.view.backgroundColor = color
        pages.append(vc)
    }
    
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
    }

}







