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
    
    let mainView: StoreDetailsView = {
        let mv = StoreDetailsView()
        return mv
    }()
    
    let optionsBar: OptionsBar = {
        let ob = OptionsBar()
        return ob
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupOptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .default
    }
    
    private func setupView() {
        view.addSubview(mainView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: mainView)
        view.addConstraintsWithFormat(format: "V:|[v0]-50-|", views: mainView)
    }
    
    private func setupOptions() {
        view.addSubview(optionsBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: optionsBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]|", views: optionsBar)
    }
    
    
}
