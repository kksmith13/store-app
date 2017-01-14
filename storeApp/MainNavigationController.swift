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
        updateSettings()
        updateLoggedInStatus()
    }
    
    fileprivate func configureTheme(){
        let backgroundColor = UIColor.init(red: 230/255, green: 232/255, blue: 225/255, alpha: 1)
        UserDefaults.standard.setColor(color: backgroundColor, forKey: "backgroundColor")
        
        let primaryColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        navigationBar.barTintColor = primaryColor
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBar.tintColor = .white
    }
    
    fileprivate func updateSettings() {
        Configuration
            .getSettingsFromAPI(success: {(response) -> Void in },
                                failure: {(error) -> Void in
                                    print(error)
            })
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
                                self.goHome()
                            },
                             failure: {(error) -> Void in
                                print(error)
                                self.goHome()
            })
    }
    
    fileprivate func goHome() {
        configureTheme()
        perform(#selector(showHomeController), with: nil, afterDelay: 0.01)
    }
    
    func showHomeController() {
        let homeController = HomeController()
        //let homeController = MainController()
        pushViewController(homeController, animated: true)
    }
}
