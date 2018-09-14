//
//  CheckBackCell.swift
//  storeApp
//
//  Created by Kyle Smith on 3/28/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class CheckBackCell: BaseCVCell {

    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        view.layer.borderWidth = 1
        view.layer.borderColor = borderColor?.cgColor
        return view
    }()
    
    let checkBackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.text = "Login, create an account, or check back later for coupons and more offers!"
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        let backgroundColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        button.setTitle("Login or Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(LoginController.pushSignup), for: .touchUpInside)
        return button
    }()
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(containerView)
        containerView.addSubview(checkBackLabel)
        containerView.addSubview(loginButton)
        
        _ = containerView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 16, leftConstant: -1, bottomConstant: 4, rightConstant: -1, widthConstant: 0, heightConstant: 0)
        
        addConstraintsWithFormat(format: "V:|-[v0(40)]", views: checkBackLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: checkBackLabel)
        
        _ = loginButton.anchor(checkBackLabel.bottomAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, topConstant: 8, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 32)
    
    }
}
