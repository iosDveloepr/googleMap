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
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
