//
//  UIViewController+Theme.swift
//  Clarks
//
//  Created by Kyle Smith on 7/29/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit
import SwiftyJSON

extension UIViewController {
    func configureTheme() {
        let primaryColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        navigationController?.navigationBar.barTintColor = primaryColor
    }
    
}
