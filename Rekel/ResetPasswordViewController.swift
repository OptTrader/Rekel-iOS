//
//  ResetPasswordViewController.swift
//  Rekel
//
//  Created by Chris Kong on 9/6/15.
//  Copyright (c) 2015 Rekel Team. All rights reserved.
//

import UIKit
import Parse

class ResetPasswordViewController: UIViewController
{
  @IBOutlet weak var emailTextField: UITextField!
  
  @IBAction func passwordReset(sender: UIButton)
  {
    var email = self.emailTextField.text
    var finalEmail = email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    
    // Validate the text fields
    if count(email) < 8
    {
      var alert = UIAlertView(
          title: "Invalid",
          message: "Email must be greater than 8 characters",
          delegate: self,
          cancelButtonTitle: "OK")
      alert.show()
      
    } else {
      // Send a request to reset a password
      PFUser.requestPasswordResetForEmailInBackground(finalEmail)
      
      var alert = UIAlertController(
          title: "Password Reset",
          message: "An email containing information on how to reset your password has been sent to " + finalEmail + ".",
          preferredStyle: UIAlertControllerStyle.Alert
      )
      alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  @IBAction func unwindToLogInScreen(segue: UIStoryboardSegue) {
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    if let touch = touches.first as? UITouch
    {
      self.view.endEditing(true)
      super.touchesBegan(touches, withEvent: event)
    }
  }

}
