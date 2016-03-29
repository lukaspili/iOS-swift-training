//
//  PagerViewController.swift
//  Training
//
//  Created by Lukasz on 29/03/16.
//  Copyright © 2016 Konsent. All rights reserved.
//

import UIKit

class PagerViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pages: [UIViewController]!
    private(set) var currentPage = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
    }
    
    func reload(pages: [UIViewController]) {
        print("reload \(currentPage)")
        self.pages = pages
        setViewControllers([pages[currentPage]], direction: .Forward, animated: false, completion: nil)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let index = pages.indexOf(viewController)!
        if(index == pages.count - 1) {
            return nil
        }
        
        currentPage = index
        return pages[index + 1]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let index = pages.indexOf(viewController)!
        if(index == 0) {
            return nil
        }
        
        currentPage = index
        return pages[index - 1]
    }
}
