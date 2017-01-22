//
//  CellWithImage.swift
//  storeApp
//
//  Created by Kyle Smith on 1/16/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class CellWithImage: BaseTVCell {
    
    let iconView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "info")
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        label.text = "test"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(iconView)
        addSubview(titleLabel)
        
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        addConstraintsWithFormat(format: "H:|-[v0(20)]-16-[v1]", views: iconView, titleLabel)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: iconView)
        addConstraintsWithFormat(format: "V:[v0(20)]", views: titleLabel)
        
    }
    
}
