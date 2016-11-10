//
//  SpecialSelectedViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 10/31/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class SpecialSelectedViewController: AppViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var couponTitle: UILabel!
    @IBOutlet var details: UILabel!
    @IBOutlet var expiration: UILabel!
    
    var data:JSON!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .default
        
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        let date = Configuration.dateConvert(date: data["expires"].stringValue)
        imageView.image = image
        couponTitle.text = data["name"].stringValue
        details.text = data["details"].stringValue
        expiration.text = date
    }
    
    
}
