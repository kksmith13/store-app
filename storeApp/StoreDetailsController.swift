//
//  StoreDetailsController.swift
//  storeApp
//
//  Created by Kyle Smith on 1/8/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON


class StoreDetailsController: AppViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = StoreDetailsView()
        view.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    
    
}
