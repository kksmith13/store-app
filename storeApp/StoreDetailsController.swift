//
//  StoreDetailsC.swift
//  storeApp
//
//  Created by Kyle Smith on 1/15/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit
import MapKit

class StoreDetailsController: AppViewController, UITableViewDelegate, UITableViewDataSource {
    
    var store: Store?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tv.layoutMargins = .zero
        tv.separatorInset = .zero
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView(frame: .zero)
        return tv
    }()
    
    lazy var shareButton: UIBarButtonItem = {
        let button = UIButton()
        button.setImage(UIImage(named: "share"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(StoreDetailsController.sharePressed), for: .touchUpInside)
        let buttonItem = UIBarButtonItem(customView: button)
        return buttonItem
    }()
    
    let cellWithImage = "cellWithImage"
    let infoId = "infoId"
    let locatorId = "locatorId"
    
    let rowNames = ["Ameneties", "Directions", "Call Us"]
    let rowImages = ["info", "marker-empty", "phone"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.register(InfoCell.self, forCellReuseIdentifier: infoId)
        tableView.register(LocatorCell.self, forCellReuseIdentifier: locatorId)
        tableView.register(CellWithImage.self, forCellReuseIdentifier: cellWithImage)
        
        navigationItem.rightBarButtonItem = shareButton
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let iCell = tableView.dequeueReusableCell(withIdentifier: infoId, for: indexPath) as! InfoCell
            iCell.selectionStyle = .none
            iCell.store = store
            return iCell
        } else if indexPath.row == 1 {
            let lCell = tableView.dequeueReusableCell(withIdentifier: locatorId, for: indexPath) as! LocatorCell
            lCell.selectionStyle = .none
            lCell.longitude = store?.longitude
            lCell.latitude = store?.latitude
            return lCell
        } else {
            let cCell = tableView.dequeueReusableCell(withIdentifier: cellWithImage, for: indexPath) as! CellWithImage
            cCell.iconView.image = UIImage(named: rowImages[indexPath.row - 2])
            cCell.titleLabel.text = rowNames[indexPath.row - 2]
            cCell.selectionStyle = .none
            cCell.accessoryType = .disclosureIndicator
            return cCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 104
        } else if indexPath.row == 1 {
            return 88
        } else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row){
        case 2:
            let storeAmenitiesController = StoreAmenitiesController()
            navigationItem.title = ""
            navigationController?.pushViewController(storeAmenitiesController, animated: true)
            
        case 3:
            let regionDistance: CLLocationDistance = 10000
            let coordinates = store?.coordinate
            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates!, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates!, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            
            mapItem.name = store?.address
            mapItem.openInMaps(launchOptions: options)
            
        case 4:
            if let url = URL(string: "tel://" + (store?.phone)!) , UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            } else {
                showAlert(title: "Call Unavailable", message: "This device is not capable of making a phone call")
            }
            
            
        default:
            break
        }
    
    }
    
    func sharePressed() {
        let shareAlert = UIAlertController(title: nil, message: "Share with your friends!", preferredStyle: .actionSheet)
        let emailAction = UIAlertAction(title: "Email", style: .default) { action in
            // start up the email
        }
        
        let facebookAction = UIAlertAction(title: "Facebook", style: .default) { action in
            // start up facebook share
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        shareAlert.addAction(emailAction)
        shareAlert.addAction(facebookAction)
        shareAlert.addAction(cancelAction)

        present(shareAlert, animated: true)
    }
}
