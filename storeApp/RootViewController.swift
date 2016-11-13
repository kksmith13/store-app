//
//  RootViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 8/18/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //updateLoggedInStatus()
        //Do some logic to check if logged in?
        self.performSegue(withIdentifier: "goHome", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
