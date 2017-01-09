//
//  OptionsCell.swift
//  storeApp
//
//  Created by Kyle Smith on 1/8/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class OptionsCell: BaseCVCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: ".SFUIText-Light", size: 10)
        label.text = "Directions"
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(titleLabel)
        
        //horizontal
        addConstraintsWithFormat(format: "H:[v0(24)]", views: imageView)
        addConstraintsWithFormat(format: "H:[v0(60)]", views: titleLabel)
        
        //verticle
        addConstraintsWithFormat(format: "V:|-8-[v0(24)]-4-[v1(10)]-4-|", views: imageView, titleLabel)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        
    }
}
