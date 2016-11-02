//
//  Configuration.swift
//  Clarks
//
//  Created by Kyle Smith on 7/27/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import Foundation
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
    
}


