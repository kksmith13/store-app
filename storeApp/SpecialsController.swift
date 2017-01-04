//
//  SpecialsController.swift
//  Clarks
//
//  Created by Kyle Smith on 8/6/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class SpecialsController: AppViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var hasFetchedCoupons = Bool()
    var isLoggedIn = Bool()
    var coupons = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        hasFetchedCoupons = false;
        
        self.view.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let row = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: row, animated: false)
        }
        fetchCoupons()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hasData() -> Bool {
        return coupons.count > 0
    }
    
    func checkLogin(){
        APIClient
            .sharedInstance
            .isAuthenticated(success: {(responseObject) -> Void in
                if responseObject["status"].stringValue == "200" {
                    self.isLoggedIn = true
                    self.tableView.reloadData()
                } else {
                    self.isLoggedIn = false
                    self.tableView.reloadData()
                }
                },
                             failure: {(error) -> Void in
                                print(error)
            })
    }
    
    func fetchCoupons() {
        coupons.removeAllObjects()
        APIClient
            .sharedInstance
            .loadCoupons(success: { (responseObject) -> Void in
                for(_, coupon) in responseObject["coupons"] {
                    self.coupons.add(coupon)
                }
                
                self.hasFetchedCoupons = true
                self.checkLogin()
                
                },
                         failure: {(error) -> Void in
                            self.showAlert(title: "Failed loading coupons", message: error.localizedDescription)
            })
        
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        if hasFetchedCoupons && hasData() && isLoggedIn {
            return coupons.count
//        } else if hasFetchedCoupons && hasData() {
//            return coupons.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CouponCellID")
        
        if hasData() {
            let couponDict:JSON = coupons.object(at: indexPath.row) as! JSON
            cell.textLabel?.text = couponDict["name"].stringValue
            let decodedImage = Configuration.convertBase64Image(image: couponDict["image"]["data"].stringValue)
            cell.imageView!.image = decodedImage

        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let specialController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SpecialSelectedController") as! SpecialSelectedViewController
        
        let couponDict:JSON = coupons.object(at: indexPath.row) as! JSON
        let decodedImage = Configuration.convertBase64Image(image: couponDict["image"]["data"].stringValue)
        //specialController.data = couponDict
        specialController.image = decodedImage
        
        parent?.navigationController?.pushViewController(specialController, animated: true)
    }
    

}
