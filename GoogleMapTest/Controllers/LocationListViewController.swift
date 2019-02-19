//
//  LocationListViewController.swift
//  GoogleMapTest
//
//  Created by Yermakov Anton on 2/17/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit

class LocationListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var locations = [Location](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let apiManager = ApiManager()
        apiManager.getLocations { (locations) in
            self.locations = locations.sorted(by: { $0.title < $1.title})
        }
    }


} // class

extension LocationListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if locations.count > 0{
            return locations.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if locations.count > 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as! LocationTableViewCell
            let location = locations[indexPath.row]
            cell.setUpCell(location: location)
            return cell
        }else{
            let cell = UITableViewCell()
            cell.textLabel?.text = "Пока нет ни одной точки"
            cell.textLabel?.textAlignment = .center
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if locations.count > 0 {
                let apiManager = ApiManager()
                let object = self.locations[indexPath.row].locationKey
                apiManager.remove(child: object)
                self.locations.remove(at: indexPath.row)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if locations.count > 0{
            let storybaord = UIStoryboard(name: "Main", bundle: nil)
            let tabBar = storybaord.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            let mapVc = tabBar.viewControllers?[1].contentViewcontroller as! MapViewController
            tabBar.selectedIndex = 1
            mapVc.location = locations[indexPath.row]
            self.present(tabBar, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
