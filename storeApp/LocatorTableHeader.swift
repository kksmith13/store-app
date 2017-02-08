//
//  LocatorTableHeader.swift
//  storeApp
//
//  Created by Kyle Smith on 1/25/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class LocatorTableHeader: UITableViewHeaderFooterView, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    
    let thisLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
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
    
    func setupViews() {
        
        addSubview(searchController.searchBar)
        addSubview(thisLabel)
        
        addConstraintsWithFormat(format: "H:[v0(50)]-|", views: thisLabel)
        addConstraintsWithFormat(format: "V:|-12-[v0(20)]", views: thisLabel)
    
    }
    
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    override func layoutSubviews() {
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width * 0.8, height: 44)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
