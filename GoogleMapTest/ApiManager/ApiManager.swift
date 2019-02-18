//
//  ApiManager.swift
//  GoogleMapTest
//
//  Created by Yermakov Anton on 2/18/19.
//  Copyright © 2019 Yermakov Anton. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class ApiManager{
    
    lazy var ref = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    
    func postLocation(withTitle title: String, latitude: Double, longtitude: Double){
        let locationObject : [String : Any] = ["title": title, "latitude": latitude, "longtitude": longtitude]
        guard let uid = uid else { return }
        ref.child("locations").child(uid).childByAutoId().setValue(locationObject)
    }
    
    func getLocations(completion: @escaping ([Location]) -> Void){
        guard let uid = uid else { return }
        _ = self.ref.child("locations").child(uid).observe(.value) { (snapshot) in
            var locationResponse: [Location] = []
            for location in snapshot.children{
                let snap = location as! DataSnapshot
                let object = Location(snapshot: snap)
                locationResponse.append(object)
            }
            completion(locationResponse)
        }
    }
    
    func remove(child: String) {
        guard let uid = uid else { return }
        ref.child("locations").child(uid).child(child).removeValue { error, _ in
            print(error.debugDescription)
        }
    }

    
} // class
