//
//  MainNavigationController.swift
//  storeApp
//
//  Created by Kyle Smith on 11/13/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //updateLoggedInStatus()
        
        perform(#selector(showHomeController), with: nil, afterDelay: 0.01)
    }
    
    func showHomeController() {
        let homeController = HomeController()
        pushViewController(homeController, animated: true)
    }
    
    fileprivate func updateLoggedInStatus() {
        APIClient
            .sharedInstance
            .isAuthenticated(success: {(responseObject) -> Void in
                if responseObject["status"].stringValue == "200" {
                    UserDefaults.standard.setIsLoggedIn(value: true)
                } else {
                    UserDefaults.standard.setIsLoggedIn(value: false)
                }
                },
                             failure: {(error) -> Void in
                                print(error)
            })
    }
}
