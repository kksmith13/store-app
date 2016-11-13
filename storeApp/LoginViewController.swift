//
//  LoginViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 10/12/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : AppViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = LoginCell()
        view.backgroundColor = .white
        
        observeKeyboardNotification()
        
    }
    
    fileprivate func observeKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -30, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
    }
    
    func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
    }
}
