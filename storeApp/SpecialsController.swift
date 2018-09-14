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
    let checkBackId = "checkBackId"
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Specials"
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(SpecialCell.self, forCellWithReuseIdentifier: specialId)
        collectionView?.register(CheckBackCell.self, forCellWithReuseIdentifier: checkBackId)

        user = Helpers.getUserData() as? User
        
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
        var params = Dictionary<String, Bool>()
        params["tobacco"] = user?.tobacco
        params["alcohol"] = user?.alcohol
        params["lottery"] = user?.lottery
        
        specials.removeAll()
        APIClient
            .sharedInstance
            .loadCoupons(params: params as NSDictionary, success: { (responseObject) -> Void in
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
                                debugPrint(error)
            })
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if user != nil {
            return specials.count == 0 ? 1 : specials.count
        } else {
            return specials.count == 0 ? 1 : specials.count + 1
        }

    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if user == nil {
            if specials.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: checkBackId, for: indexPath) as! CheckBackCell
                cell.checkBackLabel.text = "There are no more offers. Login or sign up to check for more!"
                return cell
            } else {
                if indexPath.row < specials.count {
                    //all the specials
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: specialId, for: indexPath) as! SpecialCell
                    cell.backgroundColor = .white
                    cell.special = specials[indexPath.item]
                    return cell
                } else {
                    //checkBack cell with login
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: checkBackId, for: indexPath) as! CheckBackCell
                    return cell
                }
            }
        } else /*user != nil*/ {
            if specials.count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: checkBackId, for: indexPath) as! CheckBackCell
                cell.checkBackLabel.text = "There are currently no offers. Check back later for more!"
                cell.loginButton.removeFromSuperview()
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: specialId, for: indexPath) as! SpecialCell
                cell.backgroundColor = .white
                cell.special = specials[indexPath.item]
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < specials.count {
            let specialController = SpecialDetailsController()
            specialController.special = specials[indexPath.row]
            
            navigationController?.pushViewController(specialController, animated: true)
        }
    }
    
    
}
