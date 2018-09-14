//
//  AppCollectionViewController.swift
//  storeApp
//
//  Created by Kyle Smith on 1/14/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class AppCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UserDefaults.standard.colorForKey(key: "backgroundColor")
    }
    
    func showAlert(title:String, message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok    = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
}
