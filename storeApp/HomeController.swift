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
    
    let mainView: HomeView = {
        let mv = HomeView()
        mv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 50)
        return mv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"

        view.addSubview(mainView)
        view.sendSubview(toBack: mainView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onLoginReleased(_ button:UIButton) {
        button.backgroundColor = .clear
        let loginController = LoginController()
        navigationController?.present(loginController, animated: true, completion: {
            //maybe do something??
        })
    }
    
}

