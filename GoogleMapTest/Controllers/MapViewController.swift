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
    var locations = [Location]()
    var location: Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        locationManager.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showLocation()
        setMarkers()
    }
    
    
    private func setMarkers(){
        let locationsVC = self.tabBarController?.viewControllers?[0].contentViewcontroller as! LocationListViewController
        self.locations = locationsVC.locations
        
        for marker in locations{
            let markerObject = GMSMarker(position: CLLocationCoordinate2D(latitude: marker.latitude, longitude: marker.longtitude))
            markerObject.title = marker.title
            markerObject.map = mapView
        }
    }
    
    private func showLocation(){
        if location != nil{
            let camera = GMSCameraPosition.camera(withLatitude: location!.latitude, longitude: location!.longtitude, zoom: 6)
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: location!.latitude, longitude: location!.longtitude))
            marker.title = location?.title
            marker.map = mapView
            mapView.selectedMarker = marker
            mapView.animate(to: camera)
            location = nil
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
} // class


extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        guard let latitude = location?.coordinate.latitude else { return }
        guard let longtitude = location?.coordinate.longitude else { return }
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longtitude, zoom: 4)
        mapView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
}

extension MapViewController: GMSMapViewDelegate, AlertMarker{
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        let apiManager = ApiManager()
        alertMarker { (title) in
            guard let title = title else { return }
            marker.title = title
            marker.map = mapView
            apiManager.postLocation(withTitle: title, latitude: coordinate.latitude, longtitude: coordinate.longitude)
        }
    }
}
