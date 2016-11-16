//
//  ViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 7/27/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeController: UIViewController {
    override var isAtTop: Bool {
        didSet {
            if isAtTop == true {
                
            } else {
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = HomeView()
        initSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if(isAtTop == false){
            checkLogin()
        }

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
                self.buildCustomBar()
                },
                    failure: {(error) -> Void in
                    print(error)
                    self.configureTheme()
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
    
    func checkLogin() {
        print(!UserDefaults.standard.isLoggedIn())
//        if !UserDefaults.standard.isLoggedIn() {
//            buildLoginButton()
//        } else {
//            loginButton.removeFromSuperview()
//        }
    }
    
}

