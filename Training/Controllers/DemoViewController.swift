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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self

        addPage(color: UIColor.greenColor())
        addPage(color: UIColor.redColor())
        addPage(color: UIColor.blueColor())
        
        
        for (index, controller) in pages.enumerate() {
            // step1: add child controller
            addChildViewController(controller)
            
            // step2: add child view to parent view
            contentView.addSubview(controller.view)
            
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







