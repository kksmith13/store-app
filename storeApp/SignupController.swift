//
//  SignupController.swift
//  storeApp
//
//  Created by Kyle Smith on 2/1/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class SignupController: AppViewController, UITextFieldDelegate {
    
    let signupView: SignupView = {
        let sv = SignupView()
        return sv
    }()
    
    let textFields = ["firstNameField", "lastNameField", "emailField", "phoneField", "passwordField", "confirmField"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Account"
        
        view.addSubview(signupView)
        _ = signupView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        signupView.firstNameField.delegate = self
        signupView.lastNameField.delegate = self
        signupView.emailField.delegate = self
        signupView.phoneField.delegate = self
        signupView.passwordField.delegate = self
        signupView.confirmField.delegate = self
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(textField.frame.midY)
        let updateY = textField.frame.midY * 0.20

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -updateY, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let okColor = UserDefaults.standard.colorForKey(key: "greenColor")?.cgColor
        let errorColor = UserDefaults.standard.colorForKey(key: "redColor")?.cgColor
        let text = textField.text!
        
        if ((textField == signupView.firstNameField || textField == signupView.lastNameField) && isNameValid(name: text) || (textField == signupView.emailField && isEmailValid(email: text)) || (textField == signupView.phoneField) && isPhoneValid(phone: text) || (textField == signupView.passwordField) && isPasswordValid(password: text) || (textField == signupView.confirmField) && isPasswordValid(password: text) && doPasswordsMatch(password: signupView.passwordField.text!, confirm: text)) {
            textField.layer.borderColor = okColor
        } else {
            textField.layer.borderColor = errorColor
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        
        if textField == signupView.firstNameField || textField == signupView.lastNameField {
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        if textField == signupView.phoneField {
            guard let text = textField.text else { return true }
            
            if(textField.text?.characters.count == 0 && range.location == 0) {
                textField.text = "(" + text
            }
            
            if(textField.text?.characters.count == 4 && range.location == 4) {
                textField.text = text + ") "
            }
            
            if(textField.text?.characters.count == 9 && range.location == 9) {
                textField.text = text + "-"
            }
            
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 14
        }
        
        return true
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func isNameValid(name: String) -> Bool {
        if name.characters.count > 1 {
            return true
        }
        
        return false
    }
    
    func isPasswordValid(password: String) -> Bool {
        if password.characters.count > 5 {
            return true
        }
        
        return false
    }
    
    func doPasswordsMatch(password: String, confirm: String) -> Bool {
        if password == confirm {
            return true
        }
        
        return false
    }
    
    func isPhoneValid(phone: String) -> Bool {
        if phone.characters.count == 14 {
            return true
        }
        
        return false
    }
    
//    func isPhoneValid(phone: String) -> Bool {
//        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        return phoneTest.evaluate(with: phone)
//    }
    
    func finishSigningUp() {
        resignFirstResponder()
        
        let first = signupView.firstNameField.text!
        let last = signupView.lastNameField.text!
        let email = signupView.emailField.text!
        let phone = signupView.phoneField.text!
        let password = signupView.passwordField.text!
        let confirm = signupView.confirmField.text!
        
        if !isNameValid(name: first) {
            showAlert(title: "First Name Invalid", message: "Must have two letters")
        } else if !isNameValid(name: last) {
            showAlert(title: "Last Name Invalid", message: "Must have two letters")
        } else if !isEmailValid(email: email) {
            showAlert(title: "Email Invalid", message: "Please input a valid email")
        } else if !isPhoneValid(phone: phone) {
            showAlert(title: "Phone Number Invalid", message: "Please Input a Valid Number")
        } else if !isPasswordValid(password: password) {
            showAlert(title: "Password Invalid", message: "Password must be 6 characters or longer")
        } else if !doPasswordsMatch(password: password, confirm: confirm) {
            showAlert(title: "Passwords do not match", message: "Please make sure that both passwords are the same")
        } else if !isPasswordValid(password: password) {
            showAlert(title: "Confirm Password Invald", message: "Confirm password must be 6 characters or longer")
        } else {
            let params:NSDictionary = [ "user_first"    : first,
                                        "user_last"     : last,
                                        "user_email"    : email,
                                        "user_phone"    : phone,
                                        "user_password" : password,
                                        "user_confirm"  : confirm]
            
            APIClient
                .sharedInstance
                .createUser(params: params,
                       success: {(responseObject) -> Void in
                        if responseObject["success"].stringValue == "false"{
                            print(responseObject)
                            self.showAlert(title: "Error", message: responseObject["message"].stringValue)
                        } else {
                            self.showAlertWithPop(title: "Success", message: responseObject["message"].stringValue)
                        }
                },
                       failure: {(error) -> Void in
                        self.showAlert(title: "Device Error", message: error.localizedDescription)
                })
        }

    }
}
