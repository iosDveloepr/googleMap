//
//  MarkerAlert.swift
//  GoogleMapTest
//
//  Created by Yermakov Anton on 2/17/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import Foundation
import UIKit

protocol AlertMarker{
    func alertMarker(success: @escaping (_ text: String?) -> Void)
}

extension AlertMarker where Self: UIViewController {
    
    func alertMarker(success: @escaping (_ text: String?) -> Void){
        let alert = UIAlertController(title: "Enter place title", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Place name"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            success(textField?.text)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true)
    }
}


