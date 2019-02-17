//
//  AppDelegate.swift
//  GoogleMapTest
//
//  Created by Yermakov Anton on 2/16/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        let isLogged = (Auth.auth().currentUser != nil) ? true : false
        navigateUserToMainScreenIf(currentUser: isLogged)
        
        GMSServices.provideAPIKey("AIzaSyD2gHYJVuItx7HaAZiiKlJtb5PaEoSb7RI")
        GMSPlacesClient.provideAPIKey("AIzaSyD2gHYJVuItx7HaAZiiKlJtb5PaEoSb7RI")
        
        return true
    }
    
    private func navigateUserToMainScreenIf(currentUser: Bool) {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        
        if currentUser{
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            window.rootViewController = tabController
        } else {
            let logginStoryboard: UIStoryboard = UIStoryboard(name: "Loggin", bundle: nil)
            let logginVC = logginStoryboard.instantiateViewController(withIdentifier: "LogginVC")
            window.rootViewController = logginVC
        }
        self.window = window
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: [:])
    }
}

