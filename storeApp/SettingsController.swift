//
//  SettingsController.swift
//  storeApp
//
//  Created by Kyle Smith on 1/23/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class SettingsController: AppViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        //this might need to be changed eventually.. probably not smart to have to -64 height here
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        let tv = UITableView(frame: frame, style: .grouped)
        tv.layoutMargins = .zero
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView(frame: .zero)
        return tv
    }()
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        user = Helpers.getUserData() as? User
        tableView.reloadData()
        
        navigationItem.title = "Settings"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationItem.title = ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (user != nil) ? 3 : 1
        case 1:
            return 2
        case 2:
            return (user != nil) ? 1 : 0
        case 3:
            return 4
        case 4:
            return 2
        case 5:
            return 1
        case 6:
            return (user != nil) ? 1 : 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                (user != nil) ? (cell.textLabel?.text = "Profile") : (cell.textLabel?.text = "Log in or Join Clark's")
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Rewards Account"
            } else {
                cell.textLabel?.text = "Change Password"
            }
        case 1:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Employment Opportunities"
            } else {
                cell.textLabel?.text = "For Employees"
            }
        case 2:
            cell.textLabel?.text = "Notifications"
        case 3:
            let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
            if indexPath.row == 0 {
                //move to top right of nav bar
                cell.textLabel?.text = "V: " + (version as! String)
                cell.accessoryType = .none
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "http://www.clark-oil.com"
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "Terms & Conditions"
            } else {
                cell.textLabel?.text = "Property Inquiry"
            }
        case 4:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Rate Our App"
            } else {
                cell.textLabel?.text = "Contact Us"
            }
        case 5:
            cell.textLabel?.text = "Tell a Friend"
        case 6:
            cell.textLabel?.text = "Logout as " + (user?.email)!
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "my account"
        case 1:
            return "Employment"
        case 3:
            return "about"
        case 4:
            return "feedback"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if(user == nil) {
                let loginController = LoginController()
                present(loginController, animated: true, completion: nil)
            } else if indexPath.row == 0 {
                let profileController = ProfileController()
                navigationController?.pushViewController(profileController, animated: true)
            }
        case 1:
            if indexPath.row == 0 {
                let employmentController = EmploymentController()
                navigationController?.pushViewController(employmentController, animated: true)
            }
        case 3:
            if indexPath.row == 1 {
                let websiteController = WebsiteController()
                navigationController?.pushViewController(websiteController, animated: true)
            }
        case 6:
            APIClient.sharedInstance.logout(success: {(responseObject) -> Void in
                debugPrint("Logged out")
                Helpers.clearUserData(entity: "User")
                _ = self.navigationController?.popViewController(animated: true)
            }, failure: {(error) -> Void in
                self.showAlert(title: "Error", message: error.localizedDescription)
            })
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
