//
//  AppView.swift
//  Clarks
//
//  Created by Kyle Smith on 10/11/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class AppView: UIView {
    
    func showAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok    = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
