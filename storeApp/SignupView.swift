//
//  SignupView.swift
//  storeApp
//
//  Created by Kyle Smith on 2/1/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class SignupView: UIScrollView, UIScrollViewDelegate {
    
    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        return view
    }()
    
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
    
    let dob: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        textField.placeholder = "Birth Date"
        textField.layer.borderColor = borderColor?.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        dp.timeZone = NSTimeZone.local
        dp.backgroundColor = .white
        dp.datePickerMode = .date
        return dp
    }()
    
    let toolbar: UIToolbar = {
        let tb = UIToolbar()
        tb.barStyle = .default
        tb.barTintColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        return tb
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(SignupView.cancelDob), for: .touchUpInside)
        return button
    }()
    
    var dateToSend = ""
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(SignupView.doneDob), for: .touchUpInside)
        return button
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDatePicker() {
        dob.inputView = datePicker
        
        dob.inputAccessoryView = toolbar
        _ = toolbar.anchor(dob.inputAccessoryView?.topAnchor, left: dob.inputAccessoryView?.leftAnchor, bottom: dob.inputAccessoryView?.bottomAnchor, right: dob.inputAccessoryView?.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        toolbar.addSubview(doneButton)
        _ = doneButton.anchor(toolbar.topAnchor, left: nil, bottom: toolbar.bottomAnchor, right: toolbar.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        
        toolbar.addSubview(cancelButton)
        _ = cancelButton.anchor(toolbar.topAnchor, left: toolbar.leftAnchor, bottom: toolbar.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func setupViews() {
        

        addSubview(contentView)
        //contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(firstNameField)
        contentView.addSubview(lastNameField)
        contentView.addSubview(emailField)
        contentView.addSubview(phoneField)
        contentView.addSubview(dob)
        contentView.addSubview(passwordField)
        contentView.addSubview(confirmField)
        contentView.addSubview(signupButton)
        contentView.addSubview(termsButton)
        
        _ = firstNameField.anchor(contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 44, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 36)
        
        _ = lastNameField.anchor(firstNameField.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 36)
        
        _ = emailField.anchor(lastNameField.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 36)
        
        _ = phoneField.anchor(emailField.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 36)
        
        _ = dob.anchor(phoneField.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 36)
        
        _ = passwordField.anchor(dob.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 36)
        
        _ = confirmField.anchor(passwordField.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 36)
        
        _ = signupButton.anchor(confirmField.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 36)
        
        _ = termsButton.anchor(signupButton.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, topConstant: 12, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 44)        
        
        
        
    }
    
    func doneDob() {
        dateToSend = Helpers.datePickerToFormattedString(date: datePicker.date, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        dob.text = Helpers.datePickerToString(date: datePicker.date, dateStyle: .long)
        passwordField.becomeFirstResponder()
        dob.resignFirstResponder()
    }
    
    func cancelDob() {
        dob.resignFirstResponder()
    }
    
}
