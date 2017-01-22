//
//  StoreAmenitiesController.swift
//  storeApp
//
//  Created by Kyle Smith on 1/22/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class StoreAmenitiesController: AppViewController, UITableViewDelegate, UITableViewDataSource {
    
    var store: Store?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        tv.layoutMargins = .zero
        tv.separatorInset = .zero
        tv.allowsSelection = false
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView(frame: .zero)
        return tv
    }()
    
    let cellId = "cellId"
    
    let exampleArray = ["24 Hours", "Air", "ATM", "Gas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.register(CellWithImage.self, forCellReuseIdentifier: cellId)
        
        navigationItem.title = "Amenities"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exampleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CellWithImage
        cell.iconView.image = UIImage(named: "check")
        cell.titleLabel.text = exampleArray[indexPath.row]
        return cell
    }

}
