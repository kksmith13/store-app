//
//  ProfileController.swift
//  storeApp
//
//  Created by Kyle Smith on 3/8/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class ProfileController: AppViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    lazy var tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let tv = UITableView(frame: frame, style: .grouped)
        tv.layoutMargins = .zero
        tv.delegate = self
        tv.dataSource = self
        //tv.tableFooterView = UIView(frame: .zero)
        return tv
    }()

    
    //MARK: - Static Cells
    let emailCell: CellWithTextInput = {
        let cell = CellWithTextInput()
        cell.isUserInteractionEnabled = false
        return cell
    }()
    
    lazy var firstNameCell: CellWithTextInput = {
        let cell = CellWithTextInput()
        cell.textField.placeholder = "First Name"
        cell.textField.delegate = self
        return cell
    }()
    
    lazy var lastNameCell: CellWithTextInput = {
        let cell = CellWithTextInput()
        cell.textField.placeholder = "Last Name"
        cell.textField.delegate = self
        return cell
    }()
    
    lazy var phoneCell: CellWithTextInput = {
        let cell = CellWithTextInput()
        cell.textField.keyboardType = .numbersAndPunctuation
        cell.textField.placeholder = "Phone Number"
        cell.textField.delegate = self
        return cell
    }()
    
    lazy var dobCell: CellWithTextInput = {
        let cell = CellWithTextInput()
        cell.textField.delegate = self
        return cell
    }()
    
    //MARK: - Other Items
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
    
    //MARK: - Footer View Items
    
    let termsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        label.text = "By completing this registration you agree to our"
        label.textAlignment = .center
        return label
    }()
    
    let termsButton: UIButton = {
        let button = UIButton(type: .system)
        let textColor = UserDefaults.standard.colorForKey(key: "linkColor")
        let primaryColor = UserDefaults.standard.colorForKey(key: "primaryColor")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium)
        button.setTitle("Terms and Conditions", for: .normal)
        button.setTitleColor(textColor, for: .normal)
        //button.addTarget(nil, action: #selector(LoginController.finishLoggingIn), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Variables
    let user = Helpers.getUserData() as! User
    var age: Int?
    var tcId = "tcId"
    var dateCell: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData(sender:)))
        navigationItem.rightBarButtonItem = saveButton
        
        tableView.register(CellWithTextInput.self, forCellReuseIdentifier: tcId)
        view.addSubview(tableView)
        
        setupKeyboardNotifications()
        setupUserData()
        setupCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Profile"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: - Keyboard Handling
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ProfileController.keyboardWillShow(notification:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ProfileController.keyboardWillHide(notification:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
        
    }
    
    func adjustInsetForKeyboardShow(show: Bool, notification: NSNotification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (show ? 1 : 0)
        tableView.contentInset.bottom = adjustmentHeight
        tableView.scrollIndicatorInsets.bottom = adjustmentHeight
    }
    
    func keyboardWillShow(notification: NSNotification) {
        adjustInsetForKeyboardShow(show: true, notification: notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        adjustInsetForKeyboardShow(show: false, notification: notification)
    }
    
    //MARK: - Internal Functions
    func setupUserData() {
        user.tobacco == false ? (tobaccoSwitch.isOn = false) : (tobaccoSwitch.isOn = true)
        user.alcohol == false ? (alcoholSwitch.isOn = false) : (alcoholSwitch.isOn = true)
        user.lottery == false ? (lotterySwitch.isOn = false) : (lotterySwitch.isOn = true)
        
        age = Helpers.calculateAgeFromDate(dob: user.dob!)
    }
    
    func setupCells() {
        datePicker.date = Helpers.dateFromString(dateString: user.dob!, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        emailCell.textField.text = user.email
        firstNameCell.textField.text = user.first
        lastNameCell.textField.text = user.last
        phoneCell.textField.text = Helpers.formatPhoneNumber(phone: user.phone!)
        dobCell.textField.text = Helpers.formattedDateToString(date: user.dob!, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", dateStyle: .long)
    }
    
    func doneDob() {
        let dob = dobCell
        dob.textField.text = Helpers.datePickerToString(date: datePicker.date, dateStyle: .long)
        dob.textField.resignFirstResponder()
    }

    func cancelDob() {
        let dob = dobCell
        dob.textField.resignFirstResponder()
    }
    
    func saveData(sender: UIBarButtonItem) {
        print("Saving...")
        
        user.tobacco = tobaccoSwitch.isOn
        user.alcohol = alcoholSwitch.isOn
        user.lottery = lotterySwitch.isOn
        
        let first = firstNameCell
        let last = lastNameCell
        let phone = phoneCell
        
        if !Helpers.isNameValid(name: first.textField.text!) {
            showAlert(title: "First Name Invalid", message: "Must have two letters")
        } else if !Helpers.isNameValid(name: last.textField.text!) {
            showAlert(title: "Last Name Invalid", message: "Must have two letters")
        } else if !Helpers.isPhoneValid(phone: phone.textField.text!) {
            showAlert(title: "Phone Number Invalid", message: "Please Input a Valid Number")
        } else if !Helpers.isDateValid(date: Helpers.datePickerToFormattedString(date: datePicker.date, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")) {
            showAlert(title: "Birth Date Invalid", message: "Please Select a Birth Date")
        } else {
            
            user.first = first.textField.text!
            user.last  = last.textField.text!
            user.phone = Helpers.unformatPhoneNumber(phone: phone.textField.text!)
            user.dob = Helpers.datePickerToFormattedString(date: datePicker.date, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
            
            //turn off content if the user changes age to under 21 or 18
            age = Helpers.calculateAgeFromDate(dob: user.dob!)
            if(age! < 21) {
                user.alcohol = false
                user.lottery = false
            }
            
            if (age! < 18) {
                user.tobacco = false
            }
            
            Helpers.updateUserData()
            
            //think about guarding user? there should be no instance where someone is in their profile without data.
            let params:Dictionary<String, Any> = [ "first"    : user.first!,
                                                   "last"     : user.last!,
                                                   "dob"      : user.dob!,
                                                   "phone"    : user.phone!,
                                                   "tobacco"  : user.tobacco,
                                                   "alcohol"  : user.alcohol,
                                                   "lottery"  : user.lottery]
            
            
            APIClient
                .sharedInstance
                .updateUser(id: user.id!,
                            params: params as NSDictionary,
                            success: {(responseObject) -> Void in
                                _ = self.navigationController?.popViewController(animated: true)
                                
                        },
                            failure: {(error) -> Void in
                                self.showAlert(title: "Could Not Login", message: error.localizedDescription)
                })
        }
    }
    
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
            switch(indexPath.row) {
            case 0:
                return emailCell
            case 1:
                return firstNameCell
            case 2:
                return lastNameCell
            case 3:
                return phoneCell
            case 4:
                let dateCell = dobCell.textField
                dateCell.inputView = datePicker
                dateCell.inputAccessoryView = toolbar
                
                _ = toolbar.anchor(dateCell.inputAccessoryView?.topAnchor, left: dateCell.inputAccessoryView?.leftAnchor, bottom: dateCell.inputAccessoryView?.bottomAnchor, right: dateCell.inputAccessoryView?.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                
                toolbar.addSubview(doneButton)
                _ = doneButton.anchor(toolbar.topAnchor, left: nil, bottom: toolbar.bottomAnchor, right: toolbar.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
                
                toolbar.addSubview(cancelButton)
                _ = cancelButton.anchor(toolbar.topAnchor, left: toolbar.leftAnchor, bottom: toolbar.bottomAnchor, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
                
                return dobCell
            default:
                break
            }
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
    
    //MARK: - TextField Functions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let first = firstNameCell.textField
        let last = lastNameCell.textField
        let phone = phoneCell.textField
        
        if (string == " ") {
            return false
        }

        if textField == first || textField == last {
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }

        if textField == phone {
            guard let text = textField.text else { return true }

            if(textField.text?.characters.count == 0 && range.location == 0) {
                textField.text = "(" + text
            }

            if(textField.text?.characters.count == 4 && range.location == 4) {
                textField.text = text + ") "
            }

            if(textField.text?.characters.count == 9 && range.location == 9) {
                textField.text = text + "-"
            }

            let newLength = text.characters.count + string.characters.count - range.length
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return newLength <= 14 && allowedCharacters.isSuperset(of: characterSet)
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == tableView.numberOfSections - 1 {
            let footerView = UIView()
            footerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.height, height: 0)
            footerView.addSubview(termsLabel)
            footerView.addSubview(termsButton)
            
            _ = termsLabel.anchor(footerView.topAnchor, left: footerView.leftAnchor, bottom: nil, right: footerView.rightAnchor, topConstant: 16, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
            _ = termsButton.anchor(termsLabel.bottomAnchor, left: footerView.leftAnchor, bottom: nil, right: footerView.rightAnchor, topConstant: 4, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
            return footerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 64
        }
        
        return 0
    }

}
