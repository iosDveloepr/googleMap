//
//  LocationTableViewCell.swift
//  GoogleMapTest
//
//  Created by Yermakov Anton on 2/17/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var locationLatitude: UILabel!
    @IBOutlet weak var locationLongtitude: UILabel!
    
    func setUpCell(location: Location){
        locationName.text = location.name
        locationLatitude.text = location.latitude.description
        locationLongtitude.text = location.longtitude.description
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
