//
//  SignUpViewController.swift
//  Rekel
//
//  Created by Chris Kong on 9/6/15.
//  Copyright (c) 2015 Rekel Team. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class SignUpViewController: UIViewController
{
  // MARK: - Outlets
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
  
  // MARK: - Methods
  
  @IBAction func signUpAction(sender: UIButton)
  {
    // Validate the text fields
//    if count(username) < 5 {
//      var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
//      alert.show()
//      
//    }
    
    if count(emailTextField.text) < 8 {
      var alert = UIAlertView(title: "Invalid",
          message: "Please enter a valid email address",
          delegate: self,
          cancelButtonTitle: "OK"
      )
      alert.show()
      
    } else if count(passwordTextField.text) < 8 {
      var alert = UIAlertView(title: "Invalid",
          message: "Password must be greater than 8 characters",
          delegate: self,
          cancelButtonTitle: "OK")
      alert.show()
      
    } else {
    
      // Build the terms and conditions alert
      let alertController = UIAlertController(title: "Agree to Terms & Conditions",
            message: "Click I AGREE to indicate that you agree to the End User Licence Agreement.",
            preferredStyle: UIAlertControllerStyle.Alert
      )
      
      alertController.addAction(UIAlertAction(title: "I AGREE",
            style: UIAlertActionStyle.Default,
            handler: { alertController in self.signUpProcess()})
      )
      
      alertController.addAction(UIAlertAction(title: "I do NOT agree",
            style: UIAlertActionStyle.Default,
            handler: nil)
      )
      
      // Display alert
      self.presentViewController(alertController, animated: true, completion: nil)
    }
  }
  
//  @IBAction func facebookSignUpAction(sender: UIButton)
//  {
//    // Build the terms and conditions alert
//    let alertController = UIAlertController(title: "Agree to Terms & Conditions",
//      message: "Click I AGREE to indicate that you agree to the End User Licence Agreement.",
//      preferredStyle: UIAlertControllerStyle.Alert
//    )
//    
//    alertController.addAction(UIAlertAction(title: "I AGREE",
//      style: UIAlertActionStyle.Default,
//      handler: { alertController in self.facebookSignUpProcess()})
//    )
//    
//    alertController.addAction(UIAlertAction(title: "I do NOT agree",
//      style: UIAlertActionStyle.Default,
//      handler: nil)
//    )
//    // Display alert
//    self.presentViewController(alertController, animated: true, completion: nil)
//  }
  
  // Sign Up method that is called when once a user has accepted the terms and conditions
  func signUpProcess()
  {
    // to change
    var username = emailTextField.text
    // Ensure username is lowercase
    username = username.lowercaseString
    
    var email = emailTextField.text
    var password = passwordTextField.text
    var finalEmail = email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
    // Run a spinner to show a task in progress
    var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    spinner.startAnimating()

    // Create new user
    var newUser = PFUser()
    newUser.username = username
    newUser.email = finalEmail
    newUser.password = password
    
    newUser.signUpInBackgroundWithBlock {
      (succeeded: Bool, error: NSError?) -> Void in
      
      if error == nil
      {
        // User needs to verify email address before continuing
        let alertController = UIAlertController(
                title: "Email Address Verification",
                message: "We have sent you an email that contains a link - please click the link before you can continue.",
                preferredStyle: UIAlertControllerStyle.Alert
        )
        
        alertController.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler: { alertController in self.signOutProcess()})
        )
        
        // Display alert
        self.presentViewController(alertController, animated: true, completion: nil)
      
      } else {
        spinner.stopAnimating()
        self.showErrorView(error!)
      }
    }
  }
  
  func signOutProcess()
  {
    // Sign out
    PFUser.logOut()
    
    // Display login view controller
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewControllerWithIdentifier("Login") as! UIViewController
    self.presentViewController(vc, animated: true, completion: nil)
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    if let touch = touches.first as? UITouch
    {
      self.view.endEditing(true)
      super.touchesBegan(touches, withEvent: event)
    }
  }
//  
//  func facebookSignUpProcess()
//  {
//    PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile","email"], block: { (user: PFUser?, error: NSError?) -> Void in
//      
//      if (error != nil)
//      {
//        self.showErrorView(error!)
//        return
//      }
//      println(user)
//      println("Current user token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
//      println("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
//      
//      if(FBSDKAccessToken.currentAccessToken() != nil)
//      {
//        self.saveFacebookUserInfo()
//        
//        // Display main view controller
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("HomeNavigation") as! UIViewController
//        self.presentViewController(vc, animated: true, completion: nil)
//      }
//
//    })
//  }
//  
//  func saveFacebookUserInfo()
//  {
//    var requestParameters = ["fields": "id, email, first_name, last_name"]
//    let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
//    userDetails.startWithCompletionHandler { (connection, result, error: NSError!) -> Void in
//      
//      if (error != nil)
//      {
//        self.showErrorView(error!)
//        return
//      }
//      
//      if (result != nil)
//      {
//        let userId: String = result["id"] as! String
//        let userFirstName: String? = result["first_name"] as? String
//        let userLastName: String? = result["last_name"] as? String
//        let userEmail: String? = result["email"] as? String
//
//        
//        let myUser: PFUser = PFUser.currentUser()!
//        
//        // save first name
//        if (userFirstName != nil) {
//          myUser.setObject(userFirstName!, forKey: "first_name")
//        }
//        
//        // save last name
//        if (userLastName != nil) {
//          myUser.setObject(userLastName!, forKey: "last_name")
//        }
//        
//        // save email address
//        if (userEmail != nil) {
//          myUser.setObject(userEmail!, forKey: "email")
//        }
//        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//          // get Facebook profile picture
//          var userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
//          let profilePictureUrl = NSURL(string: userProfile)
//          let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
//          
//          if (profilePictureData != nil)
//          {
//            let profileFileObject = PFFile(data: profilePictureData!)
//            myUser.setObject(profileFileObject, forKey: "profile_picture")
//          }
//          
//          myUser.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
//            
//            if(success)
//            {
//              println("User details are now updated")
//            } else {
//              
//              self.showErrorView(error!)
//            }
//            
//          })
//        }
//      }
//    }
//  }
 
  

}