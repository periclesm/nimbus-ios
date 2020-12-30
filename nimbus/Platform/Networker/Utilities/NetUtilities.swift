//
//  NetUtilities.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class NetUtilities: NSObject {
    
    class func Identifier() -> String {
        let baseCharacters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var identStr = ""
        
        for _ in 0..<16 {
            let random = arc4random_uniform(UInt32(baseCharacters.count))
            identStr += "\(baseCharacters[baseCharacters.index(baseCharacters.startIndex, offsetBy: Int(random))])"
        }
        
        return identStr
    }
    
    class func parametricURLString(baseURL: String, params: NSDictionary?) -> String {
        guard params != nil else {
            return baseURL
        }
        
        var returnString: String = "\(baseURL)?"
        
        for keyName in (params?.allKeys)! {
            
			let keyValue: String = self.validateKeyValue(value: params![keyName] as Any)
            returnString.append("&\(keyName)=\(keyValue)")
        }
        
        return returnString
    }
    
    class func validateKeyValue(value: Any) -> String {
        switch value {
            
        case is String:
            return (value as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
        case is NSNumber:
            return (value as! String).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            
        case is Bool:
            if value as! Bool {
                return "1" //or true
            }
            else {
                return "0" //or false
            }
            
        case is Date:
            //Convert Date
            //Return server date format
            return ""
            
        case is NSNull:
            return ""
            
        default:
            return ""
        }
    }
    
    class func sessionConfiguration(cachePolicy: NetConfig.NetworkerCachingMethod) -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = URLRequest.CachePolicy.init(rawValue: UInt(cachePolicy.rawValue))!
        config.httpShouldUsePipelining = true
        return config
    }
    
    class func HTTPStatusValidation(status: Int) -> Bool {
        switch status {
        //accepted cases
        case 100...103: return true
        case 200...203: return true
        case 300...308: return true
            
        //rejected cases
        case 400...451: return false
        case 500...511: return false
            
        //dubious cases to be based on service rules
        case 204...208: return false
        
        //anything not above: reject
        default: return false
        }
    }
}
