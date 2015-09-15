//
//  CardViewController.swift
//  RekelProjectApp
//
//  Created by Chris Kong on 8/25/15.
//  Copyright (c) 2015 rekel. All rights reserved.
//

import UIKit

class CardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
  
  @IBOutlet weak var tableView: UITableView!

  var productsTitles = ["New Balance schoenen", "Asics"]
  var hashtags = ["#girl #pink #brandne", "#boy #blue #asics"]
  var timeRemainings = ["5 mins", "55 mins"]
  var userNames = ["@sooof", "@samuel"]
  var prices = ["€12,00", "€35,00"]
  var quantities = ["10", "15"]
  var locations = ["Amsterdam", "Rotterdam"]
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.registerNib(UINib(nibName: "CardCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "CardCell")
  }
  
  // MARK: - TableView
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
    
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return productsTitles.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "CardCell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CardCell
    
    cell.productTitleLabel.text = productsTitles[indexPath.row]
    cell.hashtagsLabel.text = hashtags[indexPath.row]
    cell.timeRemainingLabel.text = timeRemainings[indexPath.row]
    cell.userLabel.text = userNames[indexPath.row]
    cell.priceLabel.text = prices[indexPath.row]
    cell.quantityLabel.text = quantities[indexPath.row]
    cell.locationLabel.text = locations[indexPath.row]
    
    return cell
  }

  
}