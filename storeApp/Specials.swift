//
//  Specials.swift
//  storeApp
//
//  Created by Kyle Smith on 11/14/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class Specials: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var hasFetchedCoupons = Bool()
    var isLoggedIn = Bool()
    var coupons = [Coupon]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Coupons"
        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(CouponCell.self, forCellWithReuseIdentifier: "CouponID")

        hasFetchedCoupons = false
        fetchCoupons()
        self.view.backgroundColor = UIColor.green
        
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        } else {
            collectionView?.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(Specials.fetchCoupons), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching coupons...", attributes: [:])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func fetchCoupons() {
        coupons.removeAll()
        APIClient
            .sharedInstance
            .loadCoupons(success: { (responseObject) -> Void in
                for(_, item) in responseObject["coupons"] {
                    
                    let decodedImage = Configuration.convertBase64Image(image: item["image"]["data"].stringValue)
                    let coupon = Coupon()
                    coupon.title = item["name"].stringValue
                    coupon.details = item["details"].stringValue
                    coupon.expires = item["expires"].stringValue
                    
                    coupon.thumbnailImage = decodedImage
                    self.coupons.append(coupon)
                    
                    
                }
                
                self.hasFetchedCoupons = true
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
        return coupons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CouponID", for: indexPath) as! CouponCell
        
        cell.coupon = coupons[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let specialController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpecialSelectedController") as! SpecialSelectedViewController
        
        //let couponDict:JSON = coupons.object(at: indexPath.row) as! JSON
        //let decodedImage = Configuration.convertBase64Image(image: couponDict["image"]["data"].stringValue)
        specialController.image = coupons[indexPath.item].thumbnailImage
        specialController.expires = coupons[indexPath.item].expires
        specialController.titl = coupons[indexPath.item].title
        specialController.detail = coupons[indexPath.item].details
        
        navigationController?.pushViewController(specialController, animated: true)
    }
    
    
}
