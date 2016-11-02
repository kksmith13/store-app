//
//  MapStore.swift
//  Clarks
//
//  Created by Kyle Smith on 8/30/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import Foundation
import MapKit

class MapStore: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        
        super.init()
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}