//
//  LoginViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 10/12/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate {
    func finishLoggingIn()
}
class LoginController : AppViewController, LoginControllerDelegate, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view = LoginView()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
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
    
    func finishLoggingIn() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [HomeController()]
        //UserDefaults.standard.setIsLoggedIn(value: true)
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}
