//
//  PagerViewController.swift
//  Training
//
//  Created by Lukasz on 29/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class PagerViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    private(set) var pages = [UIViewController]()
    private(set) var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        pages.append(storyboard!.instantiateViewControllerWithIdentifier("PageOne"))
        pages.append(storyboard!.instantiateViewControllerWithIdentifier("PageTwo"))
        
        setViewControllers([pages.first!], direction: .Forward, animated: false, completion: nil)
        
        dataSource = self
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        currentPage = pages.indexOf(viewController)!
        return pages[currentPage == 0 ? 1 : 0]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        currentPage = pages.indexOf(viewController)!
        return pages[currentPage == 0 ? 1 : 0]
    }

}
