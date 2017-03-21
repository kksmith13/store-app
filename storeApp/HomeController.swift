//
//  ViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 7/27/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeController: CustomTabBarController {
    
    var user: User?
    
    let mainView: HomeView = {
        let mv = HomeView()
        return mv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainView)
        _ = mainView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        view.sendSubview(toBack: mainView)
    }
    
    //possibly change to viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.title = "Home"
        user = Helpers.getUserData() as? User
        if user != nil {
            mainView.loginButton.removeFromSuperview()
        } else {
            mainView.showLoginButton()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.title = ""
    }
    
    func onLoginReleased(_ button:UIButton) {
        button.backgroundColor = .clear
        let loginController = LoginController()
        navigationController?.present(loginController, animated: true, completion: {
            //maybe do something??
        })
    }
    
}

