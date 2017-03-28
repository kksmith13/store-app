//
//  User+CoreDataProperties.swift
//  
//
//  Created by Kyle Smith on 3/27/17.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var alcohol: Bool
    @NSManaged public var dob: String?
    @NSManaged public var email: String?
    @NSManaged public var first: String?
    @NSManaged public var id: String?
    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var last: String?
    @NSManaged public var lottery: Bool
    @NSManaged public var phone: String?
    @NSManaged public var tobacco: Bool
    @NSManaged public var gasPreference: String?
    
    func setUserData(isLoggedIn: Bool, id: String, first: String, last: String, email: String, phone: String, dob: String, tobacco: Bool, alcohol: Bool, lottery: Bool, gasPreference: String) {
        self.alcohol = alcohol
        self.dob = dob
        self.email = email
        self.first = first
        self.id = id
        self.isLoggedIn = isLoggedIn
        self.last = last
        self.lottery = lottery
        self.phone = phone
        self.tobacco = tobacco
        self.gasPreference = gasPreference
    }

}
