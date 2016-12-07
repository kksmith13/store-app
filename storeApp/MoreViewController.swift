//
//  MoreTableViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 8/16/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class MoreViewController: AppViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.isStatusBarHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
            cell =  tableView.dequeueReusableCell(withIdentifier: "LogoutCellID", for: indexPath as IndexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        APIClient
            .sharedInstance
            .logout(success: { (responseObject) -> Void in
                print("Successfully logged out!")
                UserDefaults.standard.setIsLoggedIn(value: false)
                _ = self.navigationController?.popViewController(animated: true)
                },
                    failure: { (error) in
                        print(error)
            })
    }

}
