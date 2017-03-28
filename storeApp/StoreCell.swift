//
//  StoreCell.swift
//  storeApp
//
//  Created by Kyle Smith on 1/4/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

protocol StoreCellDelegate: class {
    func openDirections(cell: StoreCell)
    func openDetails(cell: StoreCell)
}

class StoreCell: BaseTVCell {
    
    //if delegate is just var, will create strong reference cycle (memory leak)
    weak var delegate: StoreCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.delegate = nil
    }
    
    var preference: String? {
        didSet {
            guard let store = store else {
                return
            }
            
            var price = "0"
            if preference == "Unleaded" {
                price = store.price!
            } else if preference == "Premium" {
                price = store.premium!
            } else if preference == "Diesel" {
                price = store.diesel!
            }
            
            priceLabel.text = "$" + price
        }
    }
    
    var store: Store? {
        didSet {
            guard let store = store else {
                return
            }
            nameLabel.text = store.name
            addressLabel.text = store.address
            locationLabel.text = store.city! + ", " + store.state! + " " + store.zipcode!
            distanceLabel.text = String(format: "%.1f", (store.distance)!/1609.344)
            
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightMedium)
        label.text = ""
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.text = ""
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        label.text = ""
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        label.textAlignment = .center
        label.text = ""
        return label
    }()
    
    let milesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        label.textAlignment = .center
        label.text = "miles"
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightLight)
        label.textAlignment = .center
        label.text = "$-.--"
        return label
    }()
    
    lazy var directionsButton: UIButton = {
        let button = UIButton()
        let color = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1)
        button.setTitle("Directions", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(directionsPressed(sender:)), for: .touchDown)
        return button
    }()
    
    lazy var detailsButton: UIButton = {
        let button = UIButton()
        let color = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1)
        button.setTitle("View Details", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(detailsPressed(sender:)), for: .touchDown)
        return button
    }()
    
    func directionsPressed(sender: UIButton) {
        self.delegate?.openDirections(cell: self)
    }
    
    func detailsPressed(sender: UIButton) {
        self.delegate?.openDetails(cell: self)
    }
    
    
    
    override func setupViews() {
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(locationLabel)
        addSubview(distanceLabel)
        addSubview(milesLabel)
        addSubview(priceLabel)
        addSubview(directionsButton)
        addSubview(detailsButton)
        
        //horizontal constraints
        addConstraintsWithFormat(format: "H:|-16-[v0]-24-[v1(68)]-16-|", views: nameLabel, distanceLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]", views: addressLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0]-24-[v1(68)]-16-|", views: locationLabel, milesLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0(96)]", views: directionsButton)
        addConstraintsWithFormat(format: "H:[v0]-36-[v1(68)]-16-|", views: detailsButton, priceLabel)

        //vertical constraints
        addConstraintsWithFormat(format: "V:|-[v0(18)]-4-[v1(16)]-4-[v2(16)]-[v3(16)]-|", views: nameLabel, addressLabel, locationLabel, directionsButton)
        addConstraintsWithFormat(format: "V:|-[v0(18)]-4-[v1(16)]-4-[v2(16)]-[v3(16)]-|", views: nameLabel, addressLabel, locationLabel, detailsButton)
        addConstraintsWithFormat(format: "V:|-[v0(18)]-4-[v1(14)]", views: distanceLabel, milesLabel)
        addConstraintsWithFormat(format: "V:[v0(22)]-|", views: priceLabel)
    }
}
