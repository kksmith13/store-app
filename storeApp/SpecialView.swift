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
            special.type == "deal" ? (extraLabel.text = "There's nothing needed to claim this reward. Just come to the store!") : (extraLabel.text = "Valid through " + special.expires!)
            titleLabel.text = special.title!
            detailsLabel.text = special.details! + "lorum ipsum this that the other in here and we go like this here's some more stuff to fill this out"
        }
    }
    
    let specialImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: UIFontWeightMedium)
        label.numberOfLines = 2
        label.text = ""
        return label
    }()
    
    let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        label.numberOfLines = 3
        label.text = ""
        return label
    }()
    
    let extraLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        let grayColor = UserDefaults.standard.colorForKey(key: "grayText")
        label.textColor = grayColor
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = ""
        return label
    }()

    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UserDefaults.standard.colorForKey(key: "backgroundColor")
        addSubview(specialImage)
        addSubview(titleLabel)
        addSubview(detailsLabel)
        addSubview(extraLabel)
        
        _ = specialImage.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        //Fix the height to .6 of the width
        specialImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75).isActive = true
        
        _ = titleLabel.anchorWithConstantsToTop(specialImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        _ = detailsLabel.anchorWithConstantsToTop(titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        _ = extraLabel.anchorWithConstantsToTop(detailsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
