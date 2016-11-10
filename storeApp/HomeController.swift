//
//  ViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 7/27/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class Home: CircleTabBarController {
    @IBOutlet var iconImageView: UIImageView!
    let loginButton = UIButton()
    
    override var isAtTop: Bool {
        didSet {
            if isAtTop == true {
                self.loginButton.removeFromSuperview()
            } else {
                checkLogin()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSettingsFromAPI()
        configureTheme()
        configureIcon()
        buildCustomBar()

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
        
    func buildLoginButton(){
        
        let buttonHeight = (self.view.bounds.height)*(0.065)
        loginButton.layer.cornerRadius = 8
        loginButton.setTitleColor(UIColor.white, for: UIControlState())
        loginButton.titleLabel!.font = UIFont(name: ".SFUIText-Light", size: 20)
        loginButton.setTitle("Sign In", for: UIControlState())
        loginButton.frame = CGRect(x: 16, y: (self.view.bounds.height - 49)/2 - (buttonHeight/2), width: self.view.bounds.width-32, height: buttonHeight)
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = GLOBALS.lines.cgColor
        loginButton.addTarget(self, action: #selector(Home.onLoginPressed(_:)), for: .touchDown)
        loginButton.addTarget(self, action: #selector(Home.onLoginReleased(_:)), for: .touchUpInside)
        
        self.view.addSubview(loginButton)
    }
    
    func onLoginPressed(_ button:UIButton) {
        button.backgroundColor = UIColor(red:0.81, green:0.81, blue:0.82, alpha:1.0)
    }
    
    func onLoginReleased(_ button:UIButton) {
        button.backgroundColor = .clear
        let loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as UIViewController
        navigationController?.pushViewController(loginController, animated: true)
        
    }
    
    // MARK: - Internal Functions
    
    func configureIcon() {        
        let iconImage = Configuration.convertBase64Image(image: UserDefaults.standard.string(forKey: "icon")!)
        iconImageView.image = iconImage
    }
    
    func checkLogin() {
        APIClient
            .sharedInstance
            .isAuthenticated(success: {(responseObject) -> Void in
                if responseObject["status"].stringValue == "200" {
                    if(self.view.subviews.contains(self.loginButton)) {
                        self.loginButton.removeFromSuperview()
                    }
                } else {
                    self.buildLoginButton()
                }
            },
                failure: {(error) -> Void in
                    print(error)
        })
    }
    
}

