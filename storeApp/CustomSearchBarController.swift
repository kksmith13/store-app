//
//  CustomSearchBarController.swift
//  storeApp
//
//  Created by Kyle Smith on 1/25/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class CustomSearchController: UISearchController, UISearchBarDelegate {
    
    lazy var _searchBar: CustomSearchBar = {
        [unowned self] in
        let result = CustomSearchBar(frame: .zero)
        result.delegate = self
        
        return result
        }()
    
    override var searchBar: UISearchBar {
        get {
            return _searchBar
        }
    }
}
