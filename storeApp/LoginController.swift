//
//  LoginViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 10/12/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class LoginController : AppViewController, LoginViewDelegate, UITextFieldDelegate {
    
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
    
    func onLoginPressed(_ button: UIButton) {
        
    }

    
    func finishLoggingIn() {
        let email = self.view.subviews[1] as! UITextField
        let emailText = email.text!
        let password = self.view.subviews[2] as! UITextField
        let passwordText = password.text!
        
        if(passwordText.characters.count == 0 || emailText.characters.count == 0) {
            showAlert(title: "Error", message: "Email or password is empty.")
        } else {
        
        let params:NSDictionary = [ "email"    : emailText,
                                    "password" : passwordText]
        
            APIClient
                .sharedInstance
                .login(params: params,
                       success: {(responseObject) -> Void in
                        if responseObject["success"].stringValue == "false"{
                            self.showAlert(title: "Error", message: "Invalid email or password")
                        } else {
                            let rootViewController = UIApplication.shared.keyWindow?.rootViewController
                            guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
                            
                            mainNavigationController.viewControllers = [HomeController()]
                            UserDefaults.standard.setIsLoggedIn(value: true)
                            self.view.endEditing(true)
                            self.dismiss(animated: true, completion: nil)
                            
                        }
                    },
                       failure: {(error) -> Void in
                        self.showAlert(title: "Could Not Login", message: error.localizedDescription)
                })
        }
    }
    
    func cancelLoggingIn() {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else { return }
        
        mainNavigationController.viewControllers = [HomeController()]
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}
