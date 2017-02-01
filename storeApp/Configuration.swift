//
//  Configuration.swift
//  Clarks
//
//  Created by Kyle Smith on 7/27/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class Configuration : NSObject {
    
    static func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func dateConvert(date:String) -> String{
        
        let dateString = date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let nsDate = dateFormatter.date(from: dateString)
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let convertedDate = dateFormatter.string(from: nsDate!)
        
        return convertedDate
    }
    
    static func convertBase64Image(image: String) -> UIImage {
        
        let imageData = image
        let encodedImage = NSData(base64Encoded: imageData, options: .ignoreUnknownCharacters)
        let decodedImage = UIImage(data: encodedImage as! Data)!
        
        return decodedImage
    }
    
    static func getSettingsFromAPI(success: @escaping (AnyObject!) -> Void,
                                   failure: @escaping (NSError) -> Void) {
        APIClient
            .sharedInstance
            .loadSettings(success: {(responseObject) -> Void in
                let defaults = UserDefaults.standard
                let primary = responseObject["setting"][0]["primaryColor"].stringValue
                let secondary = responseObject["setting"][0]["secondaryColor"].stringValue
                let primaryUIC = Configuration.hexStringToUIColor(hex: primary)
                let secondaryUIC = Configuration.hexStringToUIColor(hex: secondary)
                defaults.setColor(color: primaryUIC, forKey: "primaryColor")
                defaults.setColor(color: secondaryUIC, forKey: "secondaryColor")
                defaults.setValue(responseObject["setting"][0]["appIcon"]["data"].stringValue, forKey: "icon")
                defaults.synchronize()
                success(responseObject as AnyObject!)
                },
                          failure: {(error) -> Void in
                            failure(error)
                            print(error)
            })
    }
    
}


