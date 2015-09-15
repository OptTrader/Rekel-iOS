//
//  ProductUploadViewController.swift
//  Rekel
//
//  Created by Chris Kong on 8/30/15.
//  Copyright (c) 2015 Rekel Team. All rights reserved.
//

import UIKit

class ProductUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
  @IBOutlet weak var imageToUpload: UIImageView!
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var priceTextField: UITextField!
  @IBOutlet weak var quantityTextField: UITextField!
  @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
  @IBOutlet weak var publishButton: UIButton!
  
  var username: String?
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: - Methods
  
  @IBAction func selectPictureButtonPressed(sender: UIButton)
  {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    presentViewController(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func publishButtonPressed(sender: UIButton)
  {
    titleTextField.resignFirstResponder()
    priceTextField.resignFirstResponder()
    quantityTextField.resignFirstResponder()
    publishButton.enabled = false
    
    loadingSpinner.startAnimating()
    
    let pictureData = UIImagePNGRepresentation(imageToUpload.image)
    
    let file = PFFile(name: "image", data: pictureData)
    file.saveInBackgroundWithBlock({ (succeeded, error) -> Void in
      if succeeded
      {
        self.saveUpload(file)
      } else if let error = error
      {
        self.showErrorView(error)
      }
    }, progressBlock: { percent in
      println("Uploaded: \(percent)%")
    })
  }

  func saveUpload(file: PFFile)
  {
    let price = (priceTextField.text as NSString).doubleValue
    let quantity = (quantityTextField.text as NSString).integerValue
    let product = Product(image: file, user: PFUser.currentUser()!, title: self.titleTextField.text, price: price, quantity: quantity)
    product.saveInBackgroundWithBlock { succeeded, error in
      if succeeded
      {
        self.navigationController?.popViewControllerAnimated(true)
      } else
      {
        if let errorMessage = error?.userInfo?["error"] as? String {
          self.showErrorView(error!)
        }
      }
    }
  }

  
}

extension ProductUploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
    //Place the image in the imageview
    imageToUpload.image = image
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
}