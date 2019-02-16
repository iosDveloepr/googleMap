//
//  ViewController.swift
//  GoogleMap
//
//  Created by Yermakov Anton on 2/16/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth

class LogginViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
} // class



extension LogginViewController: GIDSignInUIDelegate, GIDSignInDelegate, AlertDisplayer{
   
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        
        if let error = error {
            displayAlert(with: "Some problems with sign in", message: error.localizedDescription)
        }
        
        guard let user = user else { return }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                self.displayAlert(with: "Some problems with sign in", message: error.localizedDescription)
            }
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            self.present(tabController, animated: true, completion: nil)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        self.displayAlert(with: "Some problems with sign in", message: error.localizedDescription)
    }
    
}
