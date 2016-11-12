//
//  APIClient.swift
//  Clarks
//
//  Created by Kyle Smith on 8/30/16.
//  Copyright © 2016 Codesmiths. All rights reserved.
//

import Foundation
import Alamofire
import KeychainAccess
import SwiftyJSON


class APIClient {
    static let sharedInstance = APIClient()
    
    let keychain = Keychain(service: "com.codesmiths.storeapp")
    let APITokenKey      = "authToken"
//    #if DEBUG
//    let baseAPIURL    = "http://10.0.0.56:3000/api"
//    #else
//    let baseAPIURL    = "http://codesmiths.com/api"
//    #endif
    //let baseAPIURL    = "http://10.0.0.56:3000/api"
    let baseAPIURL = "http://10.0.0.47:3000/api"
    let loginVerifyBase  = "http://10.0.0.47:3000"
    
    // MARK: - Internal Functions
    func getAccessToken() -> String? {
        return try! keychain.getString(APITokenKey)
    }
    
    func setAccessToken(token: String) {
        do {
            try keychain.set(token, key: APITokenKey)
        }
        catch let error {
            print(error)
        }
    }
    
    func setupGETHeaders() -> NSDictionary {
        var token:String
        
        if getAccessToken() != nil {
            token = "Bearer " + getAccessToken()!
        } else {
            token = ""
        }
        
        let verifyHeaders:NSDictionary = [
            "Authorization": token,
            "Content-Type" : "application/json",
            "Accept"       : "application/json" ]
        
        return verifyHeaders
    }
    
    // MARK: - REST API Functions
    
    func GET(urlString: URLConvertible,
             headers: NSDictionary,
             success: @escaping (JSON) -> Void,
             failure: @escaping (NSError) -> Void) {
        
        Alamofire
            .request(urlString, method: .get, headers: headers as? HTTPHeaders)
            .responseJSON { (responseObject) -> Void in
                
                if responseObject.result.isSuccess {
                    let resJSON = JSON(responseObject.result.value!)
                    success(resJSON)
                }
                
                if responseObject.result.isFailure {
                    let error : Error = responseObject.result.error!
                    failure(error as NSError)
                }
        }
    }
    
    func POST(urlString:URLConvertible,
              parameters:NSDictionary,
              headers:NSDictionary,
              success: @escaping (JSON) -> Void,
              failure: @escaping (NSError) -> Void) {
        
            Alamofire
                .request(urlString, method: .post, parameters: parameters as? Parameters, encoding: URLEncoding.default, headers: headers as? HTTPHeaders)
                .responseJSON { (responseObject) -> Void in
                    print("Here's what you're looking for...")
                    print(responseObject)
    
                    if responseObject.result.isSuccess {
                        let resJSON = JSON(responseObject.result.value!)
                        success(resJSON)
                    }
                    
                    if responseObject.result.isFailure {
                        let error : Error = responseObject.result.error!
                        failure(error as NSError)
                    }
            }
        }
    
    // MARK: - External Functions
    func isAuthenticated(success: @escaping (JSON) -> Void,
                         failure: @escaping (NSError) -> Void){
        
        let verifyHeaders:NSDictionary = setupGETHeaders()
        let verifyURL:URLConvertible = loginVerifyBase + "/verify"
        
        GET(urlString: verifyURL,
            headers: verifyHeaders,
            success: {(responseObject) -> Void in
                success(responseObject)
            },
            failure: failure)
    }
    
    func login(params: NSDictionary,
               success: @escaping (JSON) -> Void,
               failure: @escaping (NSError) -> Void) {
        
        let loginURL:URLConvertible = loginVerifyBase + "/login"
        let loginHeaders:NSDictionary = ["Accept" : "application/json"]
        
        return POST(urlString: loginURL,
                    parameters: params,
                    headers: loginHeaders,
                    success: {(responseObject) -> Void in
                        print(responseObject)
                        self.setAccessToken(token: responseObject["authtoken"].stringValue)
                        
                        success(responseObject)
                    },
                    failure: failure)
    }
    
    func logout(success: @escaping (JSON) -> Void,
                failure: @escaping (NSError) -> Void) {
        
        let logoutURL:URLConvertible = baseAPIURL + "/logout"
        let logoutHeaders = setupGETHeaders()
        
        return GET(urlString: logoutURL,
                   headers: logoutHeaders,
                   success: {(responseObject) -> Void in
                        success(responseObject)
                        try! self.keychain.remove(self.APITokenKey)
                   },
                   failure: failure)
    }
    
    func loadSettings(success: @escaping (JSON) -> Void,
                    failure: @escaping (NSError) -> Void) {
        
        let storesURL:URLConvertible = baseAPIURL + "/settings"
        let loadStoresHeaders = setupGETHeaders()
        
        return GET(urlString: storesURL,
                   headers: loadStoresHeaders,
                   success: {(responseObject) -> Void in
                    success(responseObject)
            },
                   failure: failure)
    }
    
    func loadStores(success: @escaping (JSON) -> Void,
                    failure: @escaping (NSError) -> Void) {
        
        let storesURL:URLConvertible = baseAPIURL + "/stores"
        let loadStoresHeaders = setupGETHeaders()
        
        return GET(urlString: storesURL,
                   headers: loadStoresHeaders,
                   success: {(responseObject) -> Void in
                    success(responseObject)
                   },
                   failure: failure)
    }
    
    func loadCoupons(success: @escaping (JSON) -> Void,
                     failure: @escaping (NSError) -> Void) {
        
        let couponsURL:URLConvertible = baseAPIURL + "/coupons"
        let loadCouponsHeaders = setupGETHeaders()
        
        return GET(urlString: couponsURL,
                   headers: loadCouponsHeaders,
                   success: {(responseObject) -> Void in
                    success(responseObject)
            },
                   failure: failure)
    }
}
