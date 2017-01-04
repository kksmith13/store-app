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
//        let width = UIScreen.main.bounds.size.width
//        let height = UIScreen.main.bounds.size.height
//        let imageViewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        imageViewBackground.image = Configuration.getImageFromConfig("background", type: "png")
//        
//        imageViewBackground.contentMode = UIViewContentMode.scaleAspectFill
//        view.addSubview(imageViewBackground)
//        view.sendSubview(toBack: imageViewBackground)
        navigationController?.navigationBar.barTintColor = Configuration.hexStringToUIColor(hex: UserDefaults.standard.string(forKey: "primaryColor")!)
    }
    
}
