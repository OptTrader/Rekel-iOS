//
//  LoginViewController.swift
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

class LoginViewController: UIViewController
{
  // MARK: - Outlets
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func preferredStatusBarStyle() -> UIStatusBarStyle {
    return UIStatusBarStyle.LightContent
  }
  
  override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
    if let touch = touches.first as? UITouch
    {
      self.view.endEditing(true)
      super.touchesBegan(touches, withEvent: event)
    }
  }
  
  // MARK: - Methods
  
  @IBAction func loginAction(sender: UIButton)
  {
    // to change
    var username = self.emailTextField.text
    var password = self.passwordTextField.text
    
    // Validate the text fields
    if count(username) < 5 {
      var alert = UIAlertView(
          title: "Invalid",
          message: "Username must be greater than 5 characters",
          delegate: self,
          cancelButtonTitle: "OK"
      )
      alert.show()
      
    } else if count(password) < 8 {
      var alert = UIAlertView(
          title: "Invalid",
          message: "Password must be greater than 8 characters",
          delegate: self,
          cancelButtonTitle: "OK"
      )
      alert.show()
      
    } else {
      
      // Run a spinner to show a task in progress
      var spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
      spinner.startAnimating()
      
      // Send a request to login
      PFUser.logInWithUsernameInBackground(username, password: password) {
        (user: PFUser?, error: NSError?) -> Void in
        
        if error == nil
        {
          if user!["emailVerified"] as! Bool == true
          {
            dispatch_async(dispatch_get_main_queue()) {
              let storyboard = UIStoryboard(name: "Main", bundle: nil)
              let vc = storyboard.instantiateViewControllerWithIdentifier("HomeNavigation") as! UIViewController
              self.presentViewController(vc, animated: true, completion: nil)
            }
            
          } else {
            // User needs to verify email address before continuing
            let alertController = UIAlertController(
                    title: "Email Address Verification",
                    message: "We have sent you an email that contains a link - please click the link before you can continue.",
                    preferredStyle: UIAlertControllerStyle.Alert
            )
            
            alertController.addAction(UIAlertAction(title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: { alertController in self.signOutProcess()})
            )
            
            // Display alert
            self.presentViewController(alertController, animated: true, completion: nil)
          }
          
        } else {
          spinner.stopAnimating()
          self.showErrorView(error!)
        }
      }
    }
  }
  
  @IBAction func facebookLoginAction(sender: UIButton)
  {
    // Build the terms and conditions alert
    let alertController = UIAlertController(title: "Agree to Terms & Conditions",
            message: "Click I AGREE to indicate that you agree to the End User Licence Agreement.",
            preferredStyle: UIAlertControllerStyle.Alert
    )
    
    alertController.addAction(UIAlertAction(title: "I AGREE",
            style: UIAlertActionStyle.Default,
            handler: { alertController in self.facebookSignUpProcess()})
    )
    
    alertController.addAction(UIAlertAction(title: "I do NOT agree",
            style: UIAlertActionStyle.Default,
            handler: nil)
    )
    // Display alert
    self.presentViewController(alertController, animated: true, completion: nil)
  }
  
  @IBAction func unwindToLogInScreen(segue: UIStoryboardSegue) {
  
  }
  
  func facebookSignUpProcess()
  {
    PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile","email"], block: { (user: PFUser?, error: NSError?) -> Void in
      
      if (error != nil)
      {
        self.showErrorView(error!)
        return
      }
      println(user)
      println("Current user token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
      println("Current user id \(FBSDKAccessToken.currentAccessToken().userID)")
      
      if(FBSDKAccessToken.currentAccessToken() != nil)
      {
        self.saveFacebookUserInfo()
        
        // Display main view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("HomeNavigation") as! UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
      }
      
    })
    //    PFFacebookUtils.logInInBackgroundWithReadPermissions(self.permissions, block: { (user: PFUser?, error: NSError?) -> Void in
    //
    //      if user == nil {
    //        println("Uh oh. The user cancelled the Facebook login.")
    //
    //      } else if user!.isNew {
    //        println("User signed up and logged in through Facebook!")
    //
    //      } else {
    //        println("User logged in through Facebook! \(user!.username)")
    //        self.getUserInfo()
    //      }
    //      
    //    })
  }
  
  func saveFacebookUserInfo()
  {
    var requestParameters = ["fields": "id, email, first_name, last_name"]
    let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
    userDetails.startWithCompletionHandler { (connection, result, error: NSError!) -> Void in
      
      if (error != nil)
      {
        self.showErrorView(error!)
        return
      }
      
      if (result != nil)
      {
        let userId: String = result["id"] as! String
        let userFirstName: String? = result["first_name"] as? String
        let userLastName: String? = result["last_name"] as? String
        let userEmail: String? = result["email"] as? String
        
        let myUser: PFUser = PFUser.currentUser()!
        
        // save first name
        if (userFirstName != nil) {
          myUser.setObject(userFirstName!, forKey: "first_name")
        }
        
        // save last name
        if (userLastName != nil) {
          myUser.setObject(userLastName!, forKey: "last_name")
        }
        
        // save email address
        if (userEmail != nil) {
          myUser.setObject(userEmail!, forKey: "email")
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
          // get Facebook profile picture
          var userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
          let profilePictureUrl = NSURL(string: userProfile)
          let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
          
          if (profilePictureData != nil)
          {
            let profileFileObject = PFFile(data: profilePictureData!)
            myUser.setObject(profileFileObject, forKey: "profile_picture")
          }
          
          myUser.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
            
            if(success)
            {
              println("User details are now updated")
            } else {
              
              self.showErrorView(error!)
            }
            
          })
        }
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

  
}