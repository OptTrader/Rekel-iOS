//
//  AppDelegate.swift
//  Rekel
//
//  Created by Chris Kong on 8/28/15.
//  Copyright (c) 2015 Rekel Team. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
// import FBSDKLoginKit
import ParseFacebookUtilsV4

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    Parse.enableLocalDatastore()
    
    // Initialize Parse
    Parse.setApplicationId("NRgDzDvBmjTxMoYuWn4VAunsbCoVaWWOUp7N5RzS", clientKey: "3hXLnFilERaD5tIKCclLvuDY3E7FMirElcHufu6o")
    
    // Initialize Facebook
    PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
    
    // [Optional] Track statistics around application opens
    PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
    
    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    //return true
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    
    FBSDKAppEvents.activateApp()
  }

  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
    
    return FBSDKApplicationDelegate.sharedInstance().application(application,
        openURL: url,
        sourceApplication: sourceApplication,
        annotation: annotation)
  }
  
}