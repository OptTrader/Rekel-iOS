//
//  CardCell.swift
//  RekelProjectApp
//
//  Created by Chris Kong on 8/25/15.
//  Copyright (c) 2015 rekel. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell
{
  @IBOutlet weak var productImageView: UIImageView!
  @IBOutlet weak var userProfileImageView: UIImageView!
  @IBOutlet weak var userLabel: UILabel!
  @IBOutlet weak var timeRemainingLabel: UILabel!
  @IBOutlet weak var productTitleLabel: UILabel!
  @IBOutlet weak var hashtagsLabel: UILabel!
  @IBOutlet weak var locationImageView: UIImageView!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var quantityImageView: UIImageView!
  @IBOutlet weak var quantityLabel: UILabel!
  @IBOutlet weak var priceImageView: UIImageView!
  @IBOutlet weak var priceLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
}