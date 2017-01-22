//
//  DetailsCell.swift
//  storeApp
//
//  Created by Kyle Smith on 1/16/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class InfoCell: BaseTVCell {
    
    var store: Store? {
        didSet {
            guard let store = store else {
                return
            }
            
            storeNameLabel.text = store.name
            storeAddressLabel.text = store.address
            storePhoneButton.setTitle(store.phone, for: .normal)
            gasLabel.text = "$" + (store.price)!
            distanceLabel.text = String(format: "%.1f", (store.distance)!/1609.344) + " mi"
        }
    }
    
    let logoImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo")
        return iv
    }()
    
    let storeTypeImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "exxon")
        return iv
    }()
    
    let storeNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.text = "Clark's #53"
        return label
    }()
    
    let storeAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightMedium)
        label.textColor = UIColor.init(red: 110/255, green: 110/255, blue: 110/255, alpha: 1)
        label.text = "123 That Ave"
        return label
    }()
    
    let storeLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightMedium)
        label.textColor = UIColor.init(red: 110/255, green: 110/255, blue: 110/255, alpha: 1)
        label.text = "That City, State, 88888"
        return label
    }()
    
    let storePhoneButton: UIButton = {
        let button = UIButton()
        let color = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1)
        button.setTitle("555-555-5555", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightMedium)
        return button
    }()
    
    let distanceImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "locator-blue")
        return iv
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightMedium)
        label.text = "100.0 mi"
        return label
    }()
    
    let gasLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
        label.text = "$2.00/gal"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(logoImage)
        addSubview(storeTypeImage)
        addSubview(storeNameLabel)
        addSubview(storeAddressLabel)
        addSubview(storeLocationLabel)
        addSubview(storePhoneButton)
        addSubview(distanceImage)
        addSubview(distanceLabel)
        addSubview(gasLabel)
        
        addConstraintsWithFormat(format: "H:|-[v0(80)]-16-[v1]", views: logoImage, storeNameLabel)
        addConstraintsWithFormat(format: "H:|-[v0(80)]-16-[v1]", views: logoImage, storeAddressLabel)
        addConstraintsWithFormat(format: "H:|-[v0(80)]-16-[v1]", views: logoImage, storeLocationLabel)
        addConstraintsWithFormat(format: "H:|-[v0(80)]-16-[v1]", views: logoImage, storePhoneButton)
        addConstraintsWithFormat(format: "H:|-[v0(80)]", views: storeTypeImage)
        addConstraintsWithFormat(format: "H:[v0(20)]-4-[v1]-16-|", views: distanceImage, distanceLabel)
        addConstraintsWithFormat(format: "H:[v0]-16-|", views: gasLabel)

        
        addConstraintsWithFormat(format: "V:|[v0(50)][v1(50)]", views: logoImage, storeTypeImage)
        addConstraintsWithFormat(format: "V:|-[v0(20)]-2-[v1(10)]-2-[v2(10)]", views: storeNameLabel, storeAddressLabel, storeLocationLabel)
        addConstraintsWithFormat(format: "V:|-[v0(20)]", views: distanceImage)
        addConstraintsWithFormat(format: "V:|-[v0(20)]", views: distanceLabel)
        addConstraintsWithFormat(format: "V:[v0(15)]-|", views: storePhoneButton)
        addConstraintsWithFormat(format: "V:[v0(20)]-|", views: gasLabel)


    }
    
}
