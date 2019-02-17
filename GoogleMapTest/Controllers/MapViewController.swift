//
//  MapViewController.swift
//  GoogleMapTest
//
//  Created by Yermakov Anton on 2/17/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController{
    
    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    
   
} // class


extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        guard let latitude = location?.coordinate.latitude else { return }
        guard let longtitude = location?.coordinate.longitude else { return }
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longtitude, zoom:14)
        mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
}


extension MapViewController: GMSMapViewDelegate, AlertMarker{
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        
        alertMarker { (title) in
            guard let title = title else { return }
            print(title)
            print("\(coordinate.latitude) \(coordinate.longitude)")
            marker.title = title
            marker.map = mapView
        }
    }
}
