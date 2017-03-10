//
//  ProfileController.swift
//  storeApp
//
//  Created by Kyle Smith on 3/8/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class ProfileController: AppViewController, UITableViewDelegate, UITableViewDataSource {
    
    lazy var tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let tv = UITableView(frame: frame, style: .grouped)
        tv.layoutMargins = .zero
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView(frame: .zero)
        return tv
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        dp.timeZone = NSTimeZone.local
        dp.backgroundColor = .white
        dp.datePickerMode = .date
        return dp
    }()
    
    let toolbar: UIToolbar = {
        let tb = UIToolbar()
        tb.barStyle = .default
        tb.barTintColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        return tb
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(ProfileController.cancelDob), for: .touchUpInside)
        return button
    }()
    
    let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil, action: #selector(ProfileController.doneDob), for: .touchUpInside)
        return button
    }()
    
    let tobaccoSwitch: UISwitch = {
        let sw = UISwitch()
        return sw
    }()
    
    let alcoholSwitch: UISwitch = {
        let sw = UISwitch()
        return sw
    }()
    
    let lotterySwitch: UISwitch = {
        let sw = UISwitch()
        return sw
    }()
    
    var user: User?
    var age: Int?
    var tcId = "tcId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData(sender:)))
        navigationItem.rightBarButtonItem = saveButton
        
        tableView.register(CellWithTextInput.self, forCellReuseIdentifier: tcId)
        view.addSubview(tableView)
        
        setupUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Profile"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: - Internal Functions
    func setupUserData() {
        if let data = UserDefaults.standard.object(forKey: "user") {
            user = NSKeyedUnarchiver.unarchiveObject(with: data as! Data) as? User
        }
        
        user?.tobacco == false ? (tobaccoSwitch.isOn = false) : (tobaccoSwitch.isOn = true)
        user?.alcohol == false ? (alcoholSwitch.isOn = false) : (alcoholSwitch.isOn = true)
        user?.lottery == false ? (lotterySwitch.isOn = false) : (lotterySwitch.isOn = true)
        
        age = getUserAge()
    }
    
    func getUserAge() -> Int {
        //can't set dateStyle or it crashes
        //let dob = Helpers.dateToString(date: (user?.dob)!, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", dateStyle: .long)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dob = dateFormatter.date(from: (user?.dob)!)
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dob!, to: Date())
        let age = ageComponents.year!
        return age
    }
    
    func doneDob() {
        print(datePicker.date)
        
        user?.dob = Helpers.datePickerToFormattedString(date: datePicker.date, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        
        tableView.reloadData()
        resignFirstResponder()
    }

    func cancelDob() {
        resignFirstResponder()
    }
    
    func saveData(sender: UIBarButtonItem) {
        print("Saving...")
        
        user?.tobacco = tobaccoSwitch.isOn
        user?.alcohol = alcoholSwitch.isOn
        user?.lottery = lotterySwitch.isOn
        
        //think about guarding user? there should be no instance where someone is in their profile without data.
        let params:Dictionary<String, Any> = [ "first"    : user!.first,
                                               "last"     : user!.last,
                                               "dob"      : user!.dob,
                                               "phone"    : user!.phone,
                                               "tobacco"  : user!.tobacco,
                                               "alcohol"  : user!.alcohol,
                                               "lottery"  : user!.lottery]
        
        
        APIClient
            .sharedInstance
            .updateUser(id: (user?.id)!,
                        params: params as NSDictionary,
                        success: {(responseObject) -> Void in
                            let defaults = UserDefaults.standard
                            let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.user!)
                            defaults.set(encodedData, forKey: "user")
                            defaults.synchronize()
                            _ = self.navigationController?.popViewController(animated: true)
                            
                    },
                        failure: {(error) -> Void in
                            self.showAlert(title: "Could Not Login", message: error.localizedDescription)
            })
        }
    
    //MARK: - TextField Functions
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if (string == " ") {
//            return false
//        }
//        
//        if textField == signupView.firstNameField || textField == signupView.lastNameField {
//            let allowedCharacters = CharacterSet.letters
//            let characterSet = CharacterSet(charactersIn: string)
//            return allowedCharacters.isSuperset(of: characterSet)
//        }
//        
//        if textField == signupView.phoneField {
//            guard let text = textField.text else { return true }
//            
//            if(textField.text?.characters.count == 0 && range.location == 0) {
//                textField.text = "(" + text
//            }
//            
//            if(textField.text?.characters.count == 4 && range.location == 4) {
//                textField.text = text + ") "
//            }
//            
//            if(textField.text?.characters.count == 9 && range.location == 9) {
//                textField.text = text + "-"
//            }
//            
//            let newLength = text.characters.count + string.characters.count - range.length
//            return newLength <= 14
//        }
//        
//        return true
//    }
    
    //MARK: - Table View Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return age! >= 18 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
            return age! >= 21 ? 3 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.accessoryType = .disclosureIndicator
        if indexPath.section == 0 {
            let textCell = tableView.dequeueReusableCell(withIdentifier: tcId, for: indexPath) as! CellWithTextInput
            switch(indexPath.row) {
            case 0:
                textCell.textField.text = user?.email
                textCell.isUserInteractionEnabled = false
            case 1:
                textCell.textField.text = user?.first
                textCell.textField.placeholder = "First Name"
            case 2:
                textCell.textField.text = user?.last
                textCell.textField.placeholder = "Last Name"
            case 3:
                textCell.textField.keyboardType = .phonePad
                textCell.textField.text = user?.phone
                textCell.textField.placeholder = "Phone Number"
            case 4:
                let dateCell = textCell.textField
                dateCell.text = Helpers.formattedDateToString(date: (user?.dob)!, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", dateStyle: .long)
                datePicker.date = Helpers.dateFromString(dateString: (user?.dob)!, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
                dateCell.inputView = datePicker
                dateCell.inputAccessoryView = toolbar
                
                _ = toolbar.anchor(dateCell.inputAccessoryView?.topAnchor, left: dateCell.inputAccessoryView?.leftAnchor, bottom: dateCell.inputAccessoryView?.bottomAnchor, right: dateCell.inputAccessoryView?.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                
                toolbar.addSubview(doneButton)
                _ = doneButton.anchor(toolbar.topAnchor, left: nil, bottom: toolbar.bottomAnchor, right: toolbar.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
                
                toolbar.addSubview(cancelButton)
                _ = cancelButton.anchor(toolbar.topAnchor, left: toolbar.leftAnchor, bottom: toolbar.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                
            default:
                break
            }
            return textCell
        } else if indexPath.section == 1 {
            cell.selectionStyle = .none
            switch(indexPath.row) {
            case 0:
                cell.textLabel?.text = "Tobacco"
                cell.accessoryView = tobaccoSwitch
            case 1:
                cell.textLabel?.text = "Alcohol"
                cell.accessoryView = alcoholSwitch
            case 2:
                cell.textLabel?.text = "Lottery"
                cell.accessoryView = lotterySwitch
            default:
                break;
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "View Age Restricted Content"
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

