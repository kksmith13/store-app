//
//  Store.swift
//  storeApp
//
//  Created by Kyle Smith on 1/8/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import MapKit

class Store: NSObject, MKAnnotation{
    var name: String?
    var address: String?
    var city: String?
    var state: String?
    var zipcode: String?
    var phone: String?
    var price: String?
    var distance: Double?
    var latitude: Double?
    var longitude: Double?
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func location() -> CLLocation {
        return CLLocation(latitude: latitude!, longitude: longitude!)
    }
}
