//
//  LocatorCell.swift
//  storeApp
//
//  Created by Kyle Smith on 1/16/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit
import MapKit

class LocatorCell: BaseTVCell {
    
    let regionRadius: CLLocationDistance = 500
    var latitude: Double? {
        didSet {
            let initialLocation = CLLocation(latitude: latitude!, longitude: longitude!)
            centerMapOnLocation(initialLocation)
            let pinLocation = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
            let pin = MKPointAnnotation()
            pin.coordinate = pinLocation
            mapView.addAnnotation(pin)
        }
    }
    var longitude: Double?
    
    let mapView:MKMapView = {
        let mv = MKMapView()
        return mv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(mapView)
        _ = mapView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
    }
    
    // MARK: - Map Functions
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
