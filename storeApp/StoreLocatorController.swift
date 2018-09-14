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


class StoreLocatorController: AppViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchResultsUpdating {
    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    var position = 0
    let regionRadius: CLLocationDistance = 4000
    
    var initialLocation: CLLocation?

    lazy var locatorMap: MKMapView = {
        let mv = MKMapView()
        mv.delegate = self
        mv.showsUserLocation = true
        return mv
    }()
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            lm.delegate = self
            lm.desiredAccuracy = kCLLocationAccuracyBest
            lm.startUpdatingLocation()
        }
        return lm
    }()
    
    lazy var storeInfo: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        return view
    }()
    
    var sheetBottomConstraint: NSLayoutConstraint?
    
    lazy var bottomSheet: BottomSheetView = {
        let sheet = BottomSheetView()
        sheet.storeController = self
        return sheet
    }()
    
    let cellId = "cellId"
    let headerId = "headerId"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        
        let currentLatitude = locationManager.location?.coordinate.latitude
        let currentLongitude = locationManager.location?.coordinate.longitude
        
        initialLocation = CLLocation(latitude: currentLatitude!, longitude: currentLongitude!)
        centerMapOnLocation(initialLocation!)

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Find A Store"
        
    }
    
    //MARK: - Internal Functions
    func setupViews() {
        view.addSubview(locatorMap)
        view.addSubview(storeInfo)

        _ = locatorMap.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: bottomSheet.fullSheetHeight)
        
        addLocationsToMap()
        setupBottomSheet()
    }
    
    //MARK: - Bottom Sheet
    func setupBottomSheet() {
        let initialConstant = bottomSheet.partialConstant
        view.addSubview(bottomSheet)
        
        sheetBottomConstraint = bottomSheet.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: initialConstant)
        sheetBottomConstraint?.isActive = true
        
        _ = bottomSheet.anchor(nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: bottomSheet.fullSheetHeight)
    }

    func sortLocations() {
        bottomSheet.locations.sort {Int($0.distance!) < Int($1.distance!)}
    }
    
    func setPosition() {
        for (i, store) in bottomSheet.locations.enumerated() {
            store.position = i
        }
    }
    
    // MARK: - Map Functions
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        locatorMap.setRegion(coordinateRegion, animated: true)
    }
    
    //function that sets annotations on map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKPointAnnotation.self) || annotation is MKUserLocation {
            return nil
        }
        
        if let annotation = annotation as? Store {
            
            let storeIdentifier = "store"
            var annotationView: MKAnnotationView?
            if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: storeIdentifier) {
                annotationView = dequeuedAnnotationView
                annotationView?.annotation = annotation
            }
            else {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: storeIdentifier)
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            
            if let annotationView = annotationView {
                // Configure your annotation view here
                //annotationView.canShowCallout = true
                let storeImage = UIImage(named: "clark-marker")
                annotationView.image = storeImage
            }
            
            return annotationView

        }
        
        return nil
    }
    
    //function that adds set annotations to map
    func addLocationsToMap() {
        APIClient
            .sharedInstance
            .loadStores(success: { (responseObject) -> Void in
                for (_, stores) in responseObject["stores"] {
                    let lat = stores["latitude"].doubleValue
                    let long = stores["longitude"].doubleValue
                    let store = Store(latitude: lat, longitude: long)
                    let distance = store.location().distance(from: self.initialLocation!)
                    store.name = stores["name"].stringValue
                    store.city = stores["city"].stringValue
                    store.state = stores["state"].stringValue
                    store.zipcode = stores["zipcode"].stringValue
                    store.phone = stores["phoneNumber"].stringValue
                    store.address = stores["address"].stringValue
                    store.price = stores["gasPrice"].stringValue
                    store.premium = stores["premium"].stringValue
                    store.diesel = stores["diesel"].stringValue
                    store.distance = distance
                    self.bottomSheet.locations.append(store)
                    self.locatorMap.addAnnotation(store)
                    
                }
                
                self.sortLocations()
                self.setPosition()
                self.bottomSheet.tableView.reloadData()
                },
                        failure: {(error) -> Void in
                            self.showAlert(title: "Failed loading stores", message: error.localizedDescription)
                            
            })
        
    }
    
    // Function to handle annotation accessoryView presses
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
    }
    
    
    // MARK: - User Routing
    
    // Function to handle selecting an annotation
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //if selected mark is location....
        let directionsRequest = MKDirectionsRequest()
        let selectedLoc = view.annotation as? Store
        bottomSheet.sheetPosition = .full
        bottomSheet.tableView.selectRow(at: IndexPath.init(row: (selectedLoc?.position)!, section: 0), animated: true, scrollPosition: .middle)
        let selectedPlacemark = MKPlacemark(coordinate: (selectedLoc?.coordinate)!, addressDictionary: nil)
        let selectedMapItem = MKMapItem(placemark: selectedPlacemark)
        
        directionsRequest.source = MKMapItem.forCurrentLocation()
        directionsRequest.destination = selectedMapItem
        directionsRequest.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate {
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
        
        renderer.strokeColor = .blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
}
