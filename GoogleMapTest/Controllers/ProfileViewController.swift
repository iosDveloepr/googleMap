//
//  ProfileViewController.swift
//  GoogleMap
//
//  Created by Yermakov Anton on 2/16/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class ProfileViewController: UIViewController, AlertDisplayer {

    
    @IBAction func logOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            performSegue(withIdentifier: "logOut", sender: sender)
        } catch let signOutError as NSError {
            self.displayAlert(with: "Some problems with sign out", message: signOutError.localizedDescription)
        }
    }
    
} // class
