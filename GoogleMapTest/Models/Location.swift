//
//  Location.swift
//  GoogleMapTest
//
//  Created by Yermakov Anton on 2/17/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Location{
  
    let title: String
    let latitude: Double
    let longtitude: Double
    
    init(snapshot: DataSnapshot) {
        let locationDict = snapshot.value as! [String: AnyObject]
        title = locationDict["title"] as! String
        latitude = locationDict["latitude"] as! Double
        longtitude = locationDict["longtitude"] as! Double
    }
}
