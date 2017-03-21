//
//  Helpers.swift
//  storeApp
//
//  Created by Kyle Smith on 3/9/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit
import CoreData

class Helpers: NSObject {
    
    
    //Mark: - Core Data Functions
    static func updateUserData() {
        let context = CoreDataStack.sharedManager.managedObjectContext
        do {
            try context.save()
        } catch let err {
            print(err)
        }
    }
    
    static func clearUserData(entity: String) {
        let context = CoreDataStack.sharedManager.managedObjectContext
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
            for object in objects! {
                context.delete(object)
            }
            try context.save()
        } catch let err {
            print(err)
        }
    }
    
    static func getUserData() -> Any? {
        let context = CoreDataStack.sharedManager.managedObjectContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        do {
            return try(context.fetch(fetchRequest)).first as? User
            
        } catch let err {
            print(err)
        }
        
        return nil
    }
    
    static func calculateAgeFromDate(dob: String) -> Int {
        //can't set dateStyle or it crashes
        //let userDob = Helpers.dateFromString(date: dob, dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dob = dateFormatter.date(from: dob)
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dob!, to: Date())
        let age = ageComponents.year!
        return age
    }
    
    //MARK: - Form validation
    static func isEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func isNameValid(name: String) -> Bool {
        if name.characters.count > 1 {
            return true
        }
        
        return false
    }
    
    //temporary solution, fix
    static func isDateValid(date: String) -> Bool {
        return (date.characters.count > 1) ? true : false
    }
    
    static func isPasswordValid(password: String) -> Bool {
        if password.characters.count > 5 {
            return true
        }
        
        return false
    }
    
    static func doPasswordsMatch(password: String, confirm: String) -> Bool {
        if password == confirm {
            return true
        }
        
        return false
    }
    
    static func isPhoneValid(phone: String) -> Bool {
        if phone.characters.count == 14 {
            return true
        }
        
        return false
    }
    
    //MARK: - Phone Number Formatters
    static func formatPhoneNumber(phone: String) -> String {
        var formattedPhone = phone
        formattedPhone.insert("(", at: formattedPhone.startIndex)
        formattedPhone.insert(")", at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 4))
        formattedPhone.insert(" ", at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 5))
        formattedPhone.insert("-", at: formattedPhone.index(formattedPhone.endIndex, offsetBy: -4))
        return formattedPhone
    }
    
    static func unformatPhoneNumber(phone: String) -> String {
        var formattedPhone = phone
        formattedPhone.remove(at: formattedPhone.startIndex)
        formattedPhone.remove(at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 3))
        formattedPhone.remove(at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 3))
        formattedPhone.remove(at: formattedPhone.index(formattedPhone.startIndex, offsetBy: 6))
        return formattedPhone
    }
    
    //MARK: Date Formatters
    static func dateFromString(dateString: String, dateFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.date(from: dateString)!
    }
    
    static func datePickerToString(date: Date, dateStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
    }
    
    static func datePickerToFormattedString(date: Date, dateFormat: String) -> String {
        let dateToSendFormatter = DateFormatter()
        dateToSendFormatter.dateFormat = dateFormat
        return dateToSendFormatter.string(from: date)
        
    }
    
    static func formattedDateToString(date: String, dateFormat: String, dateStyle: DateFormatter.Style) -> String{
        let dateString = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = dateFormat
        let nsDate = dateFormatter.date(from: dateString)
        
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = .none
        let convertedDate = dateFormatter.string(from: nsDate!)
        
        return convertedDate
    }


}
