//
//  VCExtension.swift
//  GoogleMapTest
//
//  Created by Yermakov Anton on 2/19/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit

extension UIViewController{
    
    var contentViewcontroller: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController!
        } else {
            return self
        }
    }
}
