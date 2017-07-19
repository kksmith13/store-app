//
//  AboutView.swift
//  storeApp
//
//  Created by Kyle Smith on 1/23/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class AboutView: BaseView {

    let imageView: UIImageView = {
        let iv = UIImageView()
        let imageArray = [UIImage(named: "flip1")!, UIImage(named: "flip2")!, UIImage(named: "flip3")!]
        iv.animationImages = imageArray
        iv.animationDuration = 10.0
        iv.startAnimating()
        return iv
    }()
    
    let storyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 22
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        label.text = "Clark Oil Company is a locally owned, family company with 47 retail locations throughout South Mississippi and South Alabama. \n \nOur goal at Clark Oil is simple: to provide you with an excellent customer service experience each time you walk into any of our locations. \n \nOur expectations are equally simple. We strive to provide you with a friendly, knowledgeable staff, a safe, well-lit location, and clean, updated facilities. \n \nWe thank you for your interest in our company, and also thank you for your patronage."
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        addSubview(imageView)
        addSubview(storyLabel)
        
        _ = imageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = storyLabel.anchor(imageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 0)
        
        //Fix the height to .6 of the width
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
    }
}
