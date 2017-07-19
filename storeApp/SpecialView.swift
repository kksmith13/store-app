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
            detailsLabel.text = special.details!
            
            if special.type == "coupon" {
                addSubview(barcodeView)
                barcodeView.addSubview(barcodeImage)
                
                setupGesture()
                barcodeBottomConstraint = barcodeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 110)
                barcodeBottomConstraint?.isActive = true
                
                _ = barcodeView.anchor(nil, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 150)
                
                barcodeImage.translatesAutoresizingMaskIntoConstraints = false
                barcodeImage.widthAnchor.constraint(equalToConstant: 220).isActive = true
                barcodeImage.heightAnchor.constraint(equalToConstant: 110).isActive = true
                addConstraint(NSLayoutConstraint(item: barcodeImage, attribute: .centerX, relatedBy: .equal, toItem: barcodeView, attribute: .centerX, multiplier: 1, constant: 0))
                addConstraint(NSLayoutConstraint(item: barcodeImage, attribute: .centerY, relatedBy: .equal, toItem: barcodeView, attribute: .centerY, multiplier: 1, constant: 0))
            }
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
    
    let barcodeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 13
        return view
    }()
    
    let barcodeImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "barcode")
        return iv
    }()
    
    let dimmerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.65)
        return view
    }()
    
    var barcodeBottomConstraint: NSLayoutConstraint?

    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UserDefaults.standard.colorForKey(key: "backgroundColor")
        addSubview(specialImage)
        addSubview(titleLabel)
        addSubview(detailsLabel)
        addSubview(extraLabel)
        
        _ = specialImage.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        //Fix the height to .6 of the width
        specialImage.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        
        _ = titleLabel.anchorWithConstantsToTop(specialImage.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        _ = detailsLabel.anchorWithConstantsToTop(titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        _ = extraLabel.anchorWithConstantsToTop(detailsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 24, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
    }
    
    func setupGesture() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(_:)))
        barcodeView.addGestureRecognizer(gesture)
    }
    
    func panGesture(_ recognizer: UIPanGestureRecognizer) {
        let velocity = recognizer.velocity(in: self)
        
        if velocity.y < 0 {
            barcodeBottomConstraint?.constant = 13
        } else {
            barcodeBottomConstraint?.constant = 110
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.layoutIfNeeded()
        })
    }
}
