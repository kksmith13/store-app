//
//  Specials.swift
//  storeApp
//
//  Created by Kyle Smith on 11/14/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class SpecialsController: AppCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var hasFetchedSpecials = Bool()
    var isLoggedIn = Bool()
    var specials = [Special]()
    let refreshControl = UIRefreshControl()
    
    let specialId = "specialId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Specials"
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(SpecialCell.self, forCellWithReuseIdentifier: specialId)

        hasFetchedSpecials = false
        fetchSpecials()
        view.backgroundColor = UIColor.green
        
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        } else {
            collectionView?.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(SpecialsController.fetchSpecials), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching specials...", attributes: [:])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func fetchSpecials() {
        specials.removeAll()
        APIClient
            .sharedInstance
            .loadCoupons(success: { (responseObject) -> Void in
                for(_, item) in responseObject["coupons"] {
                    
                    let decodedImage = Configuration.convertBase64Image(image: item["image"]["data"].stringValue)
                    let special = Special()
                    special.title = item["name"].stringValue
                    special.details = item["details"].stringValue
                    special.type = item["type"].stringValue
                    special.convertExpiration(date: item["expires"].stringValue)
                    
                    special.thumbnailImage = decodedImage
                    self.specials.append(special)
                    
                    
                }
                
                self.hasFetchedSpecials = true
                self.checkLogin()
                },
                         failure: {(error) -> Void in
                            //self.showAlert(title: "Failed loading coupons", message: error.localizedDescription)
            })
        
    }
    
    func checkLogin(){
        APIClient
            .sharedInstance
            .isAuthenticated(success: {(responseObject) -> Void in
                if responseObject["status"].stringValue == "200" {
                    self.isLoggedIn = true
                    self.collectionView?.reloadData()
                } else {
                    self.isLoggedIn = false
                    self.collectionView?.reloadData()
                    }
                
                self.refreshControl.endRefreshing()
                },
                             failure: {(error) -> Void in
                                print(error)
            })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return specials.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: specialId, for: indexPath) as! SpecialCell
        
        cell.backgroundColor = .white
        cell.special = specials[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(16, 0, 16, 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let specialController = SpecialDetailsController()
        specialController.special = specials[indexPath.row]
        
        navigationController?.pushViewController(specialController, animated: true)
    }
    
    
}
