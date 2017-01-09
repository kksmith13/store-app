//
//  CouponCell.swift
//  storeApp
//
//  Created by Kyle Smith on 11/14/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class CouponCell: BaseCVCell {
    var coupon: Coupon? {
        didSet {
            titleLabel.text = coupon?.title
            thumbnailImageView.image = coupon?.thumbnailImage
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let disclosureArrow: UIImageView = {
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
        addSubview(disclosureArrow)
        addSubview(seperatorView)

        //horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0(108)]-8-[v1]-8-[v2(16)]-16-|", views: thumbnailImageView, titleLabel, disclosureArrow)
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-8-[v0(108)]-8-[v1(1)]|", views: thumbnailImageView, seperatorView)
        addConstraintsWithFormat(format: "V:|-54-[v0(16)]", views: disclosureArrow)
        addConstraintsWithFormat(format: "V:|-32-[v0]-32-|", views: titleLabel)
    }
}
