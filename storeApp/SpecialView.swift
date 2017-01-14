//
//  CouponView.swift
//  storeApp
//
//  Created by Kyle Smith on 1/14/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class SpecialView: BaseView {
    
    let specialImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        return iv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        addSubview(specialImage)
        
        _ = specialImage.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        //Fix the height to .6 of the width
        specialImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        
    }
}
