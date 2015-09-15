//
//  HomeViewController.swift
//  RekelProjectApp
//
//  Created by Chris Kong on 8/25/15.
//  Copyright (c) 2015 rekel. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController
{
  @IBOutlet weak var cardContainerView: UIView!
  @IBOutlet weak var listContainerView: UIView!
  @IBOutlet weak var mapContainerView: UIView!
  
  @IBAction func segmentValueChanged(sender: UISegmentedControl)
  {
    switch sender.selectedSegmentIndex {
    case 0:
      self.cardContainerView.hidden = false
      self.listContainerView.hidden = true
      self.mapContainerView.hidden = true
      break
    case 1:
      self.cardContainerView.hidden = true
      self.listContainerView.hidden = false
      self.mapContainerView.hidden = true
      break
    case 2:
      self.cardContainerView.hidden = true
      self.listContainerView.hidden = true
      self.mapContainerView.hidden = false
      break
    default:
      break
    }
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    if (PFUser.currentUser() == nil) {
      dispatch_async(dispatch_get_main_queue(), { () -> Void in
        
        let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
        self.presentViewController(viewController, animated: true, completion: nil)
      })
    }
  }
  
  @IBAction func logOutAction(sender: UIBarButtonItem)
  {
    // Send a request to log out a user
    PFUser.logOut()
    
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login") as! UIViewController
      self.presentViewController(viewController, animated: true, completion: nil)
    })
  }
  
  
  
}