//
//  LoginCell.swift
//  storeApp
//
//  Created by Kyle Smith on 11/13/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

protocol LoginViewDelegate {
    func finishLoggingIn()
    func cancelLoggingIn()
}

class LoginView: UIView {
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let emailTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter Email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        return textField
    }()

    let passwordTextField: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        let primaryColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        button.backgroundColor = primaryColor
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(LoginController.finishLoggingIn), for: .touchUpInside)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        button.backgroundColor = UIColor.init(red: 255/255, green: 59/255, blue: 48/255, alpha: 1)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(LoginController.cancelLoggingIn), for: .touchUpInside)
        return button
    }()
    
    let signupView: UIView = {
        let view = UIView()
        return view
    }()
    
    let leftMark: UIView = {
        let view = UIView()
        view.backgroundColor = UserDefaults.standard.colorForKey(key: "linesColor")
        return view
    }()
    
    let rightMark: UIView = {
        let view = UIView()
        view.backgroundColor = UserDefaults.standard.colorForKey(key: "linesColor")
        return view
    }()
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.text = "No Account?"
        return label
    }()
    
    let signupButton: UIButton = {
        let button = UIButton(type: .system)
        let primaryColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor?.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        button.setTitle("Join Clark's!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(nil, action: #selector(LoginController.pushSignup), for: .touchUpInside)
        return button
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.red, for: .normal)
        //button.addTarget(nil, action: #selector(LoginController.cancelLoggingIn), for: .touchUpInside)
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(cancelButton)
        addSubview(forgotPasswordButton)
        addSubview(signupView)
        
        _ = logoImageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -250, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 120, heightConstant: 120)
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = emailTextField.anchor(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = passwordTextField.anchor(emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = loginButton.anchor(passwordTextField.bottomAnchor, left: centerXAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 8, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = cancelButton.anchor(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: centerXAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 44)
        
        addConstraint(NSLayoutConstraint(item: forgotPasswordButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        _ = forgotPasswordButton.anchor(cancelButton.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)
        
        _ = signupView.anchor(forgotPasswordButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 94)
        
        signupView.addSubview(leftMark)
        signupView.addSubview(rightMark)
        signupView.addSubview(signupLabel)
        signupView.addSubview(signupButton)
        
        _ = leftMark.anchor(signupView.topAnchor, left: signupView.leftAnchor, bottom: nil, right: signupView.centerXAnchor, topConstant: 8, leftConstant: 0, bottomConstant: 0, rightConstant: 64, widthConstant: 0, heightConstant: 1)
        
        _ = rightMark.anchor(signupView.topAnchor, left: signupView.centerXAnchor, bottom: nil, right: signupView.rightAnchor, topConstant: 8, leftConstant: 64, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        addConstraint(NSLayoutConstraint(item: signupLabel, attribute: .centerX, relatedBy: .equal, toItem: signupView, attribute: .centerX, multiplier: 1, constant: 0))
        _ = signupLabel.anchor(signupView.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 17)
        
        _ = signupButton.anchor(signupLabel.bottomAnchor, left: signupView.leftAnchor, bottom: nil, right: signupView.rightAnchor, topConstant: 32, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 44)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LeftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}
