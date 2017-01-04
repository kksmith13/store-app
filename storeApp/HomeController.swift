//
//  ViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 7/27/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeController: CircleTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSettings() {
        Configuration
            .getSettingsFromAPI(success: {(response) -> Void in
                self.configureTheme()
                self.view = HomeView()
                self.view.backgroundColor = Configuration.hexStringToUIColor(hex: "b2b2b2")
                self.buildCustomBar()
                },
                    failure: {(error) -> Void in
                    print(error)
                    self.configureTheme()
                    self.view = HomeView()
                    self.view.backgroundColor = Configuration.hexStringToUIColor(hex: "b2b2b2")
                    self.buildCustomBar()
            })
    }
    
    func onLoginReleased(_ button:UIButton) {
        button.backgroundColor = .clear
        let loginController = LoginController()
        navigationController?.present(loginController, animated: true, completion: {
            //maybe do something??
        })
    }
    
}

