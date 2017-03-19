//
//  User+CoreDataProperties.swift
//  
//
//  Created by Kyle Smith on 3/19/17.
//
//

import Foundation
import CoreData


extension User {
    static let sharedInstance = User()

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }
    
    func setUserData(isLoggedIn: Bool, id: String, first: String, last: String, email: String, phone: String, dob: String, tobacco: Bool, alcohol: Bool, lottery: Bool) {
        self.isLoggedIn = isLoggedIn
        self.id = id
        self.first = first
        self.last = last
        self.email = email
        self.phone = phone
        self.dob = dob
        self.tobacco = tobacco
        self.alcohol = alcohol
        self.lottery = lottery
    }

    @NSManaged public var isLoggedIn: Bool
    @NSManaged public var first: String?
    @NSManaged public var last: String?
    @NSManaged public var email: String?
    @NSManaged public var phone: String?
    @NSManaged public var dob: String?
    @NSManaged public var alcohol: Bool
    @NSManaged public var lottery: Bool
    @NSManaged public var tobacco: Bool
    @NSManaged public var id: String?

}
