//
//  Location.swift
//  RekelProjectApp
//
//  Created by Chris Kong on 8/26/15.
//  Copyright (c) 2015 rekel. All rights reserved.
//

import Foundation
import MapKit

class Location
{
  let name: String
  let location: CLLocationCoordinate2D
  let id: Int?
  
  required init (aName: String, aLat: Double, aLon: Double, anID: Int?)
  {
    name = aName
    location = CLLocationCoordinate2D(latitude: aLat, longitude: aLon)
    id = anID
  }
  
}