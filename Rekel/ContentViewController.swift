//
//  ContentViewController.swift
//  Rekel
//
//  Created by Chris Kong on 9/11/15.
//  Copyright (c) 2015 Rekel Team. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController
{
  // MARK: - Outlets
  
  @IBOutlet weak var contentImageView: UIImageView!
  @IBOutlet weak var subheadingLabel: UILabel!
  @IBOutlet weak var headingLabel: UILabel!
  
  var pageIndex: Int!
  var subheadingText: String!
  var headingText: String!
  var imageFile: String!
  
  // MARK: - View Controller's Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.contentImageView.image = UIImage(named: self.imageFile)
    self.subheadingLabel.text = self.subheadingText
    self.headingLabel.text = self.headingText
  }
  
}