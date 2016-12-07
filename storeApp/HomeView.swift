//
//  HomeView.swift
//  storeApp
//
//  Created by Kyle Smith on 11/13/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class HomeView: UIView {
    let logoImageView: UIImageView = {
        let image = Configuration.convertBase64Image(image: UserDefaults.standard.string(forKey: "icon")!)
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.titleLabel!.font = UIFont(name: ".SFUIText-Light", size: 20)
        button.setTitle("Sign In", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = GLOBALS.lines.cgColor
        button.addTarget(nil, action: #selector(onLoginPressed), for: .touchDown)
        button.addTarget(nil, action: #selector(HomeController.onLoginReleased), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        _ = logoImageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -250, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        if !UserDefaults.standard.isLoggedIn() {
            addSubview(loginButton)
            _ = loginButton.anchor(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onLoginPressed(_ button:UIButton) {
        button.backgroundColor = UIColor(red:0.81, green:0.81, blue:0.82, alpha:1.0)
    }
}
