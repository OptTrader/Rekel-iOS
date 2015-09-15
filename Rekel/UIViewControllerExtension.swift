//
//  UIViewControllerExtension.swift
//  Rekel
//
//  Created by Chris Kong on 8/30/15.
//  Copyright (c) 2015 Rekel Team. All rights reserved.
//

import UIKit

extension UIViewController
{
  func showAlert(title: String, message: String)
  {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
    dispatch_async(dispatch_get_main_queue(), {
      self.presentViewController(alert, animated: true, completion: nil)
    })
  }
  
  func showErrorView(error: NSError) {
    if let errorMessage = error.userInfo?["error"] as? String
    {
      let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      dispatch_async(dispatch_get_main_queue(), {
        self.presentViewController(alert, animated: true, completion: nil)
      })
    }
  }

}