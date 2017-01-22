//
//  CouponCell.swift
//  storeApp
//
//  Created by Kyle Smith on 11/14/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class SpecialCell: BaseCVCell {
    var special: Special? {
        didSet {
            titleLabel.text = special?.title
            thumbnailImageView.image = special?.thumbnailImage
            expirationLabel.text = "Expires: " + (special?.expires)!
            
            if special?.type == "deal" {
                specialType.image = UIImage(named: "deal")
            } else {
                specialType.image = UIImage(named: "coupon")
            }
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let expirationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: UIFontWeightLight)
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: UIFontWeightLight)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    let specialType: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "forward")
        return imageView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(thumbnailImageView)
        addSubview(titleLabel)
        addSubview(expirationLabel)
        addSubview(specialType)
        addSubview(seperatorView)

        //horizontal constraints
        addConstraintsWithFormat(format: "H:|[v0(124)]-8-[v1]-8-[v2(16)]-16-|", views: thumbnailImageView, titleLabel, specialType)
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|[v0(124)][v1(1)]|", views: thumbnailImageView, seperatorView)
        addConstraintsWithFormat(format: "V:|-54-[v0(16)]", views: specialType)
        addConstraintsWithFormat(format: "V:[v0]", views: titleLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        _ = expirationLabel.anchor(nil, left: thumbnailImageView.rightAnchor, bottom: titleLabel.topAnchor, right: specialType.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 4, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
}
