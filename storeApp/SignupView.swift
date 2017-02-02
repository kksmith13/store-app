//
//  SignupView.swift
//  storeApp
//
//  Created by Kyle Smith on 2/1/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class SignupView: BaseView {
    
    let firstNameField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        textField.placeholder = "First Name"
        textField.layer.borderColor = borderColor?.cgColor
        textField.layer.borderWidth = 1
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .default
        return textField
    }()
    
    let lastNameField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        textField.placeholder = "Last Name"
        textField.layer.borderColor = borderColor?.cgColor
        textField.layer.borderWidth = 1
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.keyboardType = .default
        return textField
    }()
    
    let emailField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        textField.placeholder = "Email Address"
        textField.layer.borderColor = borderColor?.cgColor
        textField.layer.borderWidth = 1
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let phoneField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        textField.placeholder = "Phone Number"
        textField.layer.borderColor = borderColor?.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .numberPad
        return textField
    }()

    
    let passwordField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        textField.placeholder = "Password"
        textField.layer.borderColor = borderColor?.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let confirmField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        textField.placeholder = "Confirm Password"
        textField.layer.borderColor = borderColor?.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        let primaryColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        button.backgroundColor = primaryColor
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(SignupController.finishSigningUp), for: .touchUpInside)
        return button
    }()
    
    let termsButton: UIButton = {
        let button = UIButton(type: .system)
        let textColor = UserDefaults.standard.colorForKey(key: "linkColor")
        let primaryColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightThin)
        button.setTitle("Terms and Conditions", for: .normal)
        button.setTitleColor(textColor, for: .normal)
        //button.addTarget(nil, action: #selector(LoginController.finishLoggingIn), for: .touchUpInside)
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(firstNameField)
        addSubview(lastNameField)
        addSubview(emailField)
        addSubview(phoneField)
        addSubview(passwordField)
        addSubview(confirmField)
        addSubview(signupButton)
        addSubview(termsButton)
        
        _ = firstNameField.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 140, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = lastNameField.anchor(firstNameField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = emailField.anchor(lastNameField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = phoneField.anchor(emailField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = passwordField.anchor(phoneField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = confirmField.anchor(passwordField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = signupButton.anchor(confirmField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = termsButton.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 32, bottomConstant: 8, rightConstant: 32, widthConstant: 0, heightConstant: 20)
        
        
        
        
    }
    
}
