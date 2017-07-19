//
//  CustomTabBarController.swift
//  storeApp
//
//  Created by Kyle Smith on 1/10/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit
import QuartzCore

class CustomTabBarController: AppViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        let secondaryColor = UserDefaults.standard.colorForKey(key: "secondaryColor")
        cv.backgroundColor = secondaryColor
        return cv
    }()
    
    
    let centerButton: UIButton = {
        let button = UIButton()
        button.addTarget(nil, action: #selector(CustomTabBarController.pushLocator), for: .touchUpInside)
        button.layer.cornerRadius = 32
        let primaryColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        button.backgroundColor = primaryColor
        return button
    }()
    
    let centerButtonImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "locator-yellow"))
        return iv
    }()
    
    let centerButtonTitle: UILabel = {
        let label = UILabel()
        let secondaryColor = UserDefaults.standard.colorForKey(key: "secondaryColor")
        label.textColor = secondaryColor
        label.font = UIFont.systemFont(ofSize: 10, weight: UIFontWeightLight)
        label.text = "Locator"
        return label
    }()
    
    let cellId = "tbCell"
    let cellNames  = ["About", "Specials", "", "Other", "Settings"]
    let cellImages = ["info", "coupon", "", "more", "gear"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fixes the labels being pushed off screen (phew)
        edgesForExtendedLayout = []
        
        setupViews()
    }
    
    private func setupViews() {
        collectionView.register(CustomTabBarCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        view.addSubview(centerButton)
        centerButton.addSubview(centerButtonImage)
        centerButton.addSubview(centerButtonTitle)
        
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat(format: "H:[v0(64)]", views: centerButton)
        
        view.addConstraintsWithFormat(format: "V:[v0(50)]|", views: collectionView)
        view.addConstraintsWithFormat(format: "V:[v0(64)]|", views: centerButton)
        
        centerButton.addConstraintsWithFormat(format: "H:[v0(30)]", views: centerButtonImage)
        centerButton.addConstraintsWithFormat(format: "H:[v0]", views: centerButtonTitle)

        centerButton.addConstraintsWithFormat(format: "V:[v0(30)]-4-[v1(10)]", views: centerButtonImage, centerButtonTitle)
        
        view.addConstraint(NSLayoutConstraint(item: centerButton, attribute: .centerX, relatedBy: .equal, toItem: view.self, attribute: .centerX, multiplier: 1, constant: 0))
        
        centerButton.addConstraint(NSLayoutConstraint(item: centerButtonImage, attribute: .centerX, relatedBy: .equal, toItem: centerButton.self, attribute: .centerX, multiplier: 1, constant: 0))
        centerButton.addConstraint(NSLayoutConstraint(item: centerButtonTitle, attribute: .centerX, relatedBy: .equal, toItem: centerButton.self, attribute: .centerX, multiplier: 1, constant: 0))
        
        centerButton.addConstraint(NSLayoutConstraint(item: centerButtonImage, attribute: .centerY, relatedBy: .equal, toItem: centerButton.self, attribute: .centerY, multiplier: 1, constant: -8))
    }
    
    func pushLocator() {
        let transition = CATransition()
        transition.duration = 0.6
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        self.navigationController?.view.layer.add(transition, forKey: nil)
        let locatorController = StoreLocatorController()
        _ = navigationController?.pushViewController(locatorController, animated: false)
    }
    
    //MARK: - CV Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row != 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomTabBarCell
            cell.titleLabel.text = cellNames[indexPath.item]
            cell.imageView.image = UIImage(named: cellImages[indexPath.item])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 5, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionMoveIn
            transition.subtype = kCATransitionFromLeft
            self.navigationController?.view.layer.add(transition, forKey: nil)
            let aboutController = AboutController()
            navigationController?.pushViewController(aboutController, animated: true)
        case 1:
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionMoveIn
            transition.subtype = kCATransitionFromLeft
            self.navigationController?.view.layer.add(transition, forKey: nil)
            let specialsController = SpecialsController(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(specialsController, animated: true)
        case 4:
            let settingsController = SettingsController()
            navigationController?.pushViewController(settingsController, animated: true)
            
        
        default:
            break
            
        }
    }
}
