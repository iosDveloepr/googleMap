//
//  ErrorAlert.swift
//  GoogleMap
//
//  Created by Yermakov Anton on 2/16/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDisplayer {
    func displayAlert(with title: String, message: String)
}

extension AlertDisplayer where Self: UIViewController {
    func displayAlert(with title: String, message: String) {
        guard presentedViewController == nil else {
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
}
