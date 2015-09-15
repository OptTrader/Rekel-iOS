//
//  OnBoardViewController.swift
//  Rekel
//
//  Created by Chris Kong on 9/11/15.
//  Copyright (c) 2015 Rekel Team. All rights reserved.
//

import UIKit

class OnBoardViewController: UIViewController, UIPageViewControllerDataSource
{
  // MARK: - Outlets
  
  @IBOutlet weak var registerButton: UIButton!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var browseButton: UIButton!
  
  var pageViewController: UIPageViewController!
  var pageTitles: NSArray!
  var pageSubheadings: NSArray!
  var pageImages: NSArray!
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.pageTitles = NSArray(objects: "THEY GROW UP SO FAST DON'T THEY", "TIME TO SELL THE OLD AND BUY SOME NEW", "REKEL IS A BOUTIQUE MARKETPLACE")
    self.pageSubheadings = NSArray(objects: "*sigh*", "", "")
    self.pageImages = NSArray(objects: "Carousel Icon One", "Carousel Icon One", "Carousel Icon One")
    
    self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
    self.pageViewController.dataSource = self
    
    var startVC = self.viewControllerAtIndex(0) as ContentViewController
    var viewControllers = NSArray(object: startVC)
    
    self.pageViewController.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: true, completion: nil)
    
    // TO UPDATE
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 160)
    
    self.addChildViewController(self.pageViewController)
    self.view.addSubview(self.pageViewController.view)
    self.pageViewController.didMoveToParentViewController(self)
   
  }
  
  // MARK: - Methods
  
  func viewControllerAtIndex(index: Int) -> ContentViewController
  {
    if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count))
    {
      return ContentViewController()
    }
    
    var vc: ContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
    
    vc.imageFile = self.pageImages[index] as! String
    vc.headingText = self.pageTitles[index] as! String
    vc.subheadingText = self.pageSubheadings[index] as! String
    
    return vc
  }
  
  // MARK: - Page View Controller Data Source
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    
    var vc = viewController as! ContentViewController
    var index = vc.pageIndex as Int
    
    if (index == 0 || index == NSNotFound)
    {
      return nil
    }
    
    index--
    
    return self.viewControllerAtIndex(index)
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
    var vc = viewController as! ContentViewController
    var index = vc.pageIndex as Int
    
    if (index == NSNotFound)
    {
      return nil
    }
    
    return self.viewControllerAtIndex(index)
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return self.pageTitles.count
  }
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return 0
  }
  
  // To Complete
  @IBAction func close(sender: AnyObject) {
      // Update for NSUserDefaults
      //    let defaults = NSUserDefaults.standardUserDefaults()
      //    defaults.setBool(true, forKey: "hasViewedWalkthrough")
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  // NOTE: Need to segue register and sign in buttons?
  
}