//
//  LoginViewController.swift
//  Clarks
//
//  Created by Kyle Smith on 10/12/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : AppViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var email: UITextField! { didSet { email.delegate = self } }
    var password: UITextField! { didSet { password.delegate = self } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate   = self
        tableView.dataSource = self
    }
    
    //MARK: - Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0){
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell =  tableView.dequeueReusableCell(withIdentifier: "EmailCellID", for: indexPath as IndexPath)
            
            email = self.view.viewWithTag(10) as! UITextField
            
        } else if (indexPath.section == 0 && indexPath.row == 1) {
            cell =  tableView.dequeueReusableCell(withIdentifier: "PasswordCellID", for: indexPath as IndexPath)
            
            password = self.view.viewWithTag(11) as! UITextField
            
        } else if (indexPath.section == 1 && indexPath.row == 0) {
            cell =  tableView.dequeueReusableCell(withIdentifier: "LoginButtonCellID", for: indexPath as IndexPath)
            
            let loginButton:UIButton = self.view.viewWithTag(1) as! UIButton
            loginButton.addTarget(self, action: #selector(self.onLoginPressed(_:)), for: .touchUpInside)
            
        } else {
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: - Button functions
    
    func onLoginPressed(_ button: UIButton) {
        
        if(password.text?.characters.count == 0 || email.text?.characters.count == 0) {
            showAlert(title: "Error", message: "Email or password is empty.")
        } else {
            let params:NSDictionary = [ "email"    : email.text!,
                                        "password" : password.text!]
            
            APIClient
                .sharedInstance
                .login(params: params,
                       success: {(responseObject) -> Void in
                        if responseObject["success"].stringValue == "false"{
                            self.showAlert(title: "Error", message: "Invalid email or password")
                        } else {
                            _ = self.navigationController?.popViewController(animated: true)
                            
                        }
                    },
                       failure: {(error) -> Void in
                        self.showAlert(title: "Could Not Login", message: error.localizedDescription)
                })
        }
        
    }

    /*
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
     
      Configure the cell...
     
     return cell
     }
     */
    
    /*
      Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
      Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
      Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
      Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
      Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
      Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */

    
    
    
}
