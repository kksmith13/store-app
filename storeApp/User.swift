//
//  User.swift
//  storeApp
//
//  Created by Kyle Smith on 3/8/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    var id: String
    var first: String
    var last: String
    var email: String
    var phone: String
    var dob: String
    var tobacco: Bool
    var alcohol: Bool
    var lottery: Bool
    
    
    init(id: String, first: String, last: String, email: String, phone: String, dob: String, tobacco: Bool, alcohol: Bool, lottery: Bool) {
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
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let first = aDecoder.decodeObject(forKey: "first") as! String
        let last = aDecoder.decodeObject(forKey: "last") as! String
        let email = aDecoder.decodeObject(forKey: "email") as! String
        let phone = aDecoder.decodeObject(forKey: "phone") as! String
        let dob = aDecoder.decodeObject(forKey: "dob") as! String
        let tobacco = aDecoder.decodeBool(forKey: "tobacco")
        let alcohol = aDecoder.decodeBool(forKey: "alcohol")
        let lottery = aDecoder.decodeBool(forKey: "lottery")
        self.init(id: id, first: first, last: last, email: email, phone: phone, dob: dob, tobacco: tobacco, alcohol: alcohol, lottery: lottery)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(first, forKey: "first")
        aCoder.encode(last, forKey: "last")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(dob, forKey: "dob")
        aCoder.encode(tobacco, forKey: "tobacco")
        aCoder.encode(alcohol, forKey: "alcohol")
        aCoder.encode(lottery, forKey: "lottery")
    }
}
