//
//  PagerContainerViewController.swift
//  Training
//
//  Created by Lukasz on 29/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class PagerContainerViewController: UIViewController, UIPageViewControllerDelegate {
    
    private(set) var pages = [UIViewController]()

    @IBOutlet weak var pageControl: UIPageControl!
    
    private var pagerViewController: PagerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pagerViewController.delegate = self
        pageControl.currentPage = 0
        
        addPage()
    }
    
    private func reload() {
        pageControl.numberOfPages = pages.count
        pagerViewController.reload(pages)
    }
    
    private func addPage() {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("PageOne") as! PagerElementViewController
        controller.name = "Page \(pages.count + 1)"
        pages.append(controller)
        
        reload()
    }
    
    @IBAction func didTouchButton(sender: AnyObject) {
        addPage()
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
