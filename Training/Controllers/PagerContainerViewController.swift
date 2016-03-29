//
//  PagerContainerViewController.swift
//  Training
//
//  Created by Lukasz on 29/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class PagerContainerViewController: UIViewController, UIPageViewControllerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    
    private var pagerViewController: PagerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        pagerViewController = childViewControllers.first as! PagerViewController

        pagerViewController.delegate = self
        pageControl.numberOfPages = pagerViewController.pages.count
        pageControl.currentPage = 0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pager" {
            pagerViewController = segue.destinationViewController as! PagerViewController
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        pageControl.currentPage = pagerViewController.currentPage
    }

}
