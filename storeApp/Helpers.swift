//
//  Helpers.swift
//  storeApp
//
//  Created by Kyle Smith on 3/9/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

class Helpers: NSObject {
    
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
