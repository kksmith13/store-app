//
//  StoreLocatorController.swift
//  Clarks
//
//  Created by Kyle Smith on 8/16/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON


class StoreLocatorController: AppViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var locatorMap: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .default
        
        
        locatorMap.delegate = self;
        
        //For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let currentLatitude = locationManager.location?.coordinate.latitude
        let currentLongitude = locationManager.location?.coordinate.longitude
        
        let currentLocation = MKPointAnnotation()
        currentLocation.coordinate = CLLocationCoordinate2D(latitude: currentLatitude!, longitude: currentLongitude!)
        currentLocation.title = "Current Location"
        locatorMap.addAnnotation(currentLocation)
        
        let initialLocation = CLLocation(latitude: currentLatitude!, longitude: currentLongitude!)
        centerMapOnLocation(initialLocation)
        addLocationsToMap()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    // MARK: - Map Functions
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        locatorMap.setRegion(coordinateRegion, animated: true)
    }
    
    //function that sets annotations on map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKPointAnnotation.self) {
            return nil
        }
        
        var locationView = locatorMap.dequeueReusableAnnotationView(withIdentifier: "Store")
        
        if locationView == nil {
            let storeImage = Configuration.getImageFromConfig("myJR", type: "png")
            let imageSize = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(imageSize)
            storeImage.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            locationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Store")
            locationView?.canShowCallout = true
            locationView!.image = resizedImage
            
            
        } else {
            locationView!.annotation = annotation
        }
        
        return locationView
    }
    
    //function that adds set annotations to map
    func addLocationsToMap() {
        APIClient
            .sharedInstance
            .loadStores(success: { (responseObject) -> Void in
                    print(responseObject)
                    for (_, stores) in responseObject["stores"] {
                        print(stores)
                        let lat = stores["latitude"].stringValue
                        let long = stores["longitude"].stringValue
                        let location = MapStore(latitude: Double(lat)!, longitude: Double(long)!)
                        location.title = stores["name"].stringValue
                        self.locatorMap.addAnnotation(location)
                        
                    }
                },
                        failure: {(error) -> Void in
                            self.showAlert(title: "Failed loading stores", message: error.localizedDescription)
                            
            })
        
    }
    
    // Function to handle annotation accessoryView presses
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    }
    
    
    // MARK: - User Routing
    
    //Functions to handle location changing
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last! as CLLocation
//        
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        
//        locatorMap.setRegion(region, animated: true)
//    }
    
    // Function to handle selecting an annotation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let directionsRequest = MKDirectionsRequest()
        let selectedLoc = view.annotation
        let selectedPlacemark = MKPlacemark(coordinate: (selectedLoc?.coordinate)!, addressDictionary: nil)
        let selectedMapItem = MKMapItem(placemark: selectedPlacemark)
        
        directionsRequest.source = MKMapItem.forCurrentLocation()
        directionsRequest.destination = selectedMapItem
        directionsRequest.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate{
            response, error in
            
            guard let response = response else {
                //handle the error
                return
            }
            self.showRoute(response)
        }
    }
    
    // Function to add overlay to map
    func showRoute(_ response: MKDirectionsResponse) {
        locatorMap.removeOverlays(locatorMap.overlays)
        for route in response.routes {
            locatorMap.add(route.polyline, level: MKOverlayLevel.aboveRoads)
        }
    }
    
    // Function to draw route on map
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
