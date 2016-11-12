//
//  Configuration.swift
//  Clarks
//
//  Created by Kyle Smith on 7/27/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import UIKit

class Configuration : NSObject {
    
    func setupConfigurationPath() -> NSDictionary {
        

        let path = Bundle.main.path(forResource: "Config", ofType: "plist")
        
        let myDict = NSDictionary(contentsOfFile: path!)
        
        return myDict!
    }
    
    static func getColorFromConfig(_ color: NSString) -> UIColor {
        
        var setColor: UIColor?
        var colorString: String?
        
        switch(color) {
            case "primaryColor" :
                colorString = "colors.primary"
                break
            case "secondaryColor" :
                colorString = "colors.secondary"
                break
            case "green" :
                colorString = "colors.green"
                break
            case "offBlack" :
                colorString = "colors.offBlack"
                break
            case "lines" :
                colorString = "colors.lines"
                break
            default :
                setColor = UIColor.white
                break
        }
        
        
        if colorString != nil{
            let config = Configuration()
            let dict = config.setupConfigurationPath()
            let colorInfo = dict.value(forKeyPath: colorString!)
            
            let c = CIColor.init(string: colorInfo as! String)
            
            setColor = UIColor.init(red: c.red, green: c.green, blue: c.blue, alpha: c.alpha)
            
        }
        
        return setColor!
    }
    
    static func getImageFromConfig(_ name: NSString, type: NSString) -> UIImage {
        
        let config = Configuration()
        let dict = config.setupConfigurationPath()
        let imageName = dict.value(forKeyPath: name as String)
        let imagePath = Bundle.main.path(forResource: imageName as? String, ofType: type as String, inDirectory: "images")
        
        let image = UIImage(contentsOfFile: imagePath!)
        
        return image!
    }
    
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
                defaults.setValue(("#" + responseObject["setting"][0]["primaryColor"].stringValue), forKey: "primaryColor")
                defaults.setValue(("#" + responseObject["setting"][0]["secondaryColor"].stringValue), forKey: "secondaryColor")
                //print(responseObject["setting"][0]["appIcon"]["data"].stringValue)
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


