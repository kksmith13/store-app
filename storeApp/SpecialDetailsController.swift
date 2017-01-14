//
//  SpecialSelectedViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 10/31/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class SpecialDetailsController: AppViewController {
    
    let specialView: SpecialView = {
        let sv = SpecialView()
        sv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = specialView
    }
    
    override func viewDidLayoutSubviews() {
        specialView.frame = view.frame
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func configureView() {
//        let date = Configuration.dateConvert(date: expires)
//        imageView.image = image
//        couponTitle.text = titl
//        details.text = detail
//        expiration.text = date
//    }
    
    
}
