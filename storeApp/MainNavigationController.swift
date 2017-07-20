//
//  MainNavigationController.swift
//  storeApp
//
//  Created by Kyle Smith on 11/13/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import CoreData

class MainNavigationController: UINavigationController {
    
    var user = Helpers.getUserData() as? User
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSettings()
    }

    fileprivate func configureTheme(){
        let defaults = UserDefaults.standard
        let primary = UIColor(red: 0, green: 64/255, blue: 120/255, alpha: 1)
        let secondary = UIColor(red: 255/255, green: 247/255, blue: 8/255, alpha: 1)
        defaults.setColor(color: primary, forKey: "primaryColor")
        defaults.setColor(color: secondary, forKey: "secondaryColor")
        
        let backgroundColor = UIColor.init(red: 239/255, green: 238/255, blue: 244/255, alpha: 1)
        UserDefaults.standard.setColor(color: backgroundColor, forKey: "backgroundColor")
        
        let linkColor = UIColor.init(red: 0, green: 122/255, blue: 175/255, alpha: 1)
        UserDefaults.standard.setColor(color: linkColor, forKey: "linkColor")
        
        let linesColor = UIColor.init(red: 206/255, green: 206/255, blue: 210/255, alpha: 1)
        UserDefaults.standard.setColor(color: linesColor, forKey: "linesColor")
        
        let grayText = UIColor.init(red: 142/255, green: 142/255, blue: 142/255, alpha: 1)
        UserDefaults.standard.setColor(color: grayText, forKey: "grayText")
        
        let redColor = UIColor.init(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        UserDefaults.standard.setColor(color: redColor, forKey: "redColor")
        
        let greenColor = UIColor.init(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        UserDefaults.standard.setColor(color: greenColor, forKey: "greenColor")
        
        let primaryColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        navigationBar.barTintColor = primaryColor
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 22, weight: UIFontWeightLight), NSForegroundColorAttributeName: UIColor.white]
        navigationBar.tintColor = .white
    }
    
    fileprivate func updateSettings() {
        Configuration
            .getSettingsFromAPI(success: {(response) -> Void in
                                    self.updateLoggedInStatus()
                                },
                                failure: {(error) -> Void in
                                    self.updateLoggedInStatus()
                                    debugPrint(error)
            })
    }
    
    fileprivate func updateLoggedInStatus() {
        APIClient
            .sharedInstance
            .isAuthenticated(success: {(responseObject) -> Void in
                if responseObject["status"].stringValue != "200" {
                                Helpers.clearUserData(entity: "User")
                            }
                                self.goHome()
                            },
                             failure: {(error) -> Void in
                                debugPrint(error)
                                self.goHome()
            })
    }
    
    fileprivate func goHome() {
        configureTheme()
        perform(#selector(showHomeController), with: nil, afterDelay: 0.20)
    }
    
    func showHomeController() {
        let homeController = HomeController()
        //let homeController = MainController()
        pushViewController(homeController, animated: true)
    }
}
