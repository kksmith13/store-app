//
//  HomeView.swift
//  storeApp
//
//  Created by Kyle Smith on 11/13/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    var loggedIn: Bool? {
        didSet {
            if (!loggedIn!) {
                showLoginButton()
            } else {
                showWelcomeMessage()
            }
        }
    }
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "clark-tBanner")
        return iv
    }()
    
    let welcomeMessage: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightLight)
        return label
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        let borderColor = UserDefaults.standard.colorForKey(key: "linesColor")
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 20, weight: UIFontWeightLight)
        button.setTitle("Sign In", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = borderColor?.cgColor
        button.addTarget(nil, action: #selector(onLoginPressed), for: .touchDown)
        button.addTarget(nil, action: #selector(HomeController.onLoginReleased), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        _ = logoImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func showLoginButton() {
        addSubview(loginButton)
        _ = loginButton.anchor(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        welcomeMessage.removeFromSuperview()
        
    }
    
    func showWelcomeMessage() {
        addSubview(welcomeMessage)
        _ = welcomeMessage.anchor(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 30)
        loginButton.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onLoginPressed(_ button:UIButton) {
        button.backgroundColor = UIColor(red:0.81, green:0.81, blue:0.82, alpha:1.0)
    }
}
