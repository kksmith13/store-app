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
        
        //configure date
        let dateString = data["expires"].stringValue
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let nsDate = dateFormatter.date(from: dateString)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let date = dateFormatter.string(from: nsDate!)
        
        
        
        imageView.image = image
        couponTitle.text = data["name"].stringValue
        details.text = data["details"].stringValue
        expiration.text = date
    }
    
    
}
