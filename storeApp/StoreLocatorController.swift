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


class StoreLocatorController: AppViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, StoreCellDelegate {
    
    var position = 0
    let regionRadius: CLLocationDistance = 500
    
    var initialLocation: CLLocation?
    
    var locations = [Store]()

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
    
    let shButton: UIButton = {
        //let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 49, y: 0, width: 49, height: 49))
        let button = UIButton()
        //button.addTarget(nil, action: #selector(showMore), for: .touchDown)
        button.backgroundColor = .red
        return button
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        tv.sectionHeaderHeight = UITableViewAutomaticDimension
        tv.estimatedRowHeight = 24.0
        tv.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.contentInset = UIEdgeInsetsMake(0, 0, 16, 0)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return tv
    }()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.register(StoreCell.self, forCellReuseIdentifier: cellId)
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = ""
        
        let currentLatitude = locationManager.location?.coordinate.latitude
        let currentLongitude = locationManager.location?.coordinate.longitude
        
        initialLocation = CLLocation(latitude: currentLatitude!, longitude: currentLongitude!)
        centerMapOnLocation(initialLocation!)
    }
    
    //MARK: - Internal Functions
    func setupViews() {
        view.addSubview(locatorMap)
        view.addSubview(storeInfo)
        storeInfo.addSubview(shButton)
        storeInfo.addSubview(seperatorView)
        storeInfo.addSubview(tableView)
        
        _ = locatorMap.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 275, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        _ = storeInfo.anchorToTop(locatorMap.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        _ = shButton.anchor(storeInfo.topAnchor, left: nil, bottom: nil, right: storeInfo.rightAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 20, heightConstant: 20)
        _ = seperatorView.anchor(storeInfo.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 36, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        _ = tableView.anchor(seperatorView.topAnchor, left: view.leftAnchor, bottom: storeInfo.bottomAnchor , right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        addLocationsToMap()
    }

    func sortLocations() {
        locations.sort {Int($0.distance!) < Int($1.distance!)}
    }
    
    //MARK: - StoreCell Delegate Methods
    func openDirections(cell: StoreCell){
        guard tableView.indexPath(for: cell) != nil else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        let index = tableView.indexPath(for: cell)?.row
        let regionDistance: CLLocationDistance = 10000
        let coordinates = locations[index!].coordinate
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = locations[index!].address
        mapItem.openInMaps(launchOptions: options)
        
    }
    
    func openDetails(cell: StoreCell) {
        guard tableView.indexPath(for: cell) != nil else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }
        
        let index = tableView.indexPath(for: cell)?.row
        let storeDetailsController = StoreDetailsController()
        storeDetailsController.navigationItem.title = "Store Details"
        navigationItem.title = "Stores"
        print(locations[index!].address)
        storeDetailsController.store = locations[index!]
        navigationController?.pushViewController(storeDetailsController, animated: true)
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
        
        var locationView = locatorMap.dequeueReusableAnnotationView(withIdentifier: "Store")
        
        if locationView == nil {
            let storeImage = UIImage(named: "logo")
            let imageSize = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(imageSize)
            storeImage?.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
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
                    store.distance = distance
                    self.locations.append(store)
                    self.locatorMap.addAnnotation(store)
                    
                }
                
                self.sortLocations()
                self.tableView.reloadData()
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
        let directionsRequest = MKDirectionsRequest()
        let selectedLoc = view.annotation
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
        
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    //MARK: - TV Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StoreCell
        cell.delegate = self
        cell.store = locations[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    //MARK: - Extra Bar Methods
    func showMore() {
        if position == 0 {
            _ = locatorMap.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 200, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            _ = storeInfo.anchorToTop(locatorMap.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
            position = 1
        } else {
            _ = locatorMap.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 49, rightConstant: 0, widthConstant: 0, heightConstant: 0)
            _ = storeInfo.anchorToTop(locatorMap.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
            position = 0
        }
    }
    
}
