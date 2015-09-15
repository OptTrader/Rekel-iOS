//
//  Product.swift
//  RekelProjectApp
//
//  Created by Chris Kong on 8/26/15.
//  Copyright (c) 2015 rekel. All rights reserved.
//

import Foundation

class Product: PFObject, PFSubclassing
{
  @NSManaged var image: PFFile
  @NSManaged var user: PFUser
  @NSManaged var title: String
  @NSManaged var price: Double
  @NSManaged var quantity: Int
  
  class func parseClassName() -> String {
    return "Product"
  }
  
  override class func initialize() {
    var onceToken: dispatch_once_t = 0
    dispatch_once(&onceToken) {
      self.registerSubclass()
    }
  }
  
  override class func query() -> PFQuery?
  {
    let query = PFQuery(className: Product.parseClassName())
    query.includeKey("user")
    query.orderByDescending("createdAt")
    return query
  }
  
  init(image: PFFile, user: PFUser, title: String, price: Double, quantity: Int)
  {
    super.init()
    
    self.image = image
    self.user = user
    self.title = title
    self.price = price
    self.quantity = quantity
  }
  
  override init() {
    super.init()
  }
  
  
  
//  let image: String?
//  let time: String?
//  let title: String?
//  let hashtags: String?
//  let location: String?
//  let quantity: Int?
//  let price: Int?
//  
//  required init (image: String?, time: String?, title: String?, hashtags: String?, location: String?, quantity: Int?, price: Int?) {
//    self.image = image
//    self.time = time
//    self.title = title
//    self.hashtags = hashtags
//    self.location = location
//    self.quantity = quantity
//    self.price = price
//    
//  }
  



}