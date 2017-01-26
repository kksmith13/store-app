//
//  CouponView.swift
//  storeApp
//
//  Created by Kyle Smith on 1/14/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class SpecialView: BaseView {
    
    var special: Special? {
        didSet {
            guard let special = special else {
                return
            }
            specialImage.image = special.thumbnailImage
            expirationLabel.text = "Valid through " + special.expires!
            if special.type == "coupon" {
                addSubview(expirationLabel)
                _ = expirationLabel.anchor(specialImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 24, bottomConstant: 0, rightConstant: 24, widthConstant: 0, heightConstant: 0)
            }

        }
    }
    
    let specialImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let expirationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "expiration"
        label.backgroundColor = .green
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "expirationas;ldkfalskdflkasj;d a;skdjf;aksjd;f lkja;s df;lkajsdf;lk"
        label.backgroundColor = .green
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        addSubview(specialImage)
        addSubview(titleLabel)
        addSubview(detailsLabel)
        
        _ = specialImage.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        //Fix the height to .6 of the width
        specialImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
        
    }
}
