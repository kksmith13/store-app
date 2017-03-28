//
//  LocatorTableHeader.swift
//  storeApp
//
//  Created by Kyle Smith on 1/25/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

protocol LocatorTableHeaderDelegate: class {
    func changeGasType(sender: UIButton)
}

class LocatorTableHeader: UITableViewHeaderFooterView, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    
    weak var delegate: LocatorTableHeaderDelegate?
    
    lazy var gasTypeButton: UIButton = {
        let button = UIButton()
        let color = UIColor(red: 0/255, green: 122/255, blue: 1, alpha: 1)
        button.setTitle("Unleaded", for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(gasTypePressed), for: .touchDown)
        return button
    }()
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.searchBar.delegate = self
        sc.dimsBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation = false
        sc.definesPresentationContext = true
        sc.searchBar.searchBarStyle = .minimal
        return sc
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    deinit {
        searchController.isActive = false
        searchController.searchBar.endEditing(true)
    }
    
    func gasTypePressed(sender: UIButton) {
        self.delegate?.changeGasType(sender: sender)
    }
    
    func setupViews() {
        
        addSubview(searchController.searchBar)
        addSubview(gasTypeButton)
        
        addConstraintsWithFormat(format: "H:[v0(80)]-|", views: gasTypeButton)
        addConstraintsWithFormat(format: "V:|-12-[v0(20)]", views: gasTypeButton)
    
    }
    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    override func layoutSubviews() {
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.7, height: 44)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
