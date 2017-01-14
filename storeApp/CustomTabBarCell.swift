//
//  CustomTabBarCell.swift
//  storeApp
//
//  Created by Kyle Smith on 1/11/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class CustomTabBarCell: BaseCVCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: ""))
        return iv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
        label.text = "fuuuuu"
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: titleLabel)
        addConstraintsWithFormat(format: "H:[v0(24)]", views: imageView)
        
        addConstraintsWithFormat(format: "V:|-[v0(24)]-4-[v1(10)]", views: imageView, titleLabel)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
    }
}

