//
//  NetUtilities.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation

class NetUtilities: NSObject {

	/// Provides a unique (string) identifier for each network call (to be further implemented).
    class func Identifier() -> String {
        let baseCharacters: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var identStr = ""
        
        for _ in 0..<16 {
            let random = arc4random_uniform(UInt32(baseCharacters.count))
            identStr += "\(baseCharacters[baseCharacters.index(baseCharacters.startIndex, offsetBy: Int(random))])"
        }
        
        return identStr
    }

	/// Parses and deserializes JSON data in a collection (Dictionary).
	class func DataToJSON(data: Data) -> Dictionary<AnyHashable, Any> {
		if let data = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) {
			return data as! Dictionary<AnyHashable, Any>
		}

		return [:]
	}

	class func CollectionToJSON(collection: Any) -> String {
		switch collection {

			case is NSArray, is Array<Any>, is NSDictionary, is Dictionary<AnyHashable, Any>, is Set<AnyHashable>:
				guard let data = try? JSONSerialization.data(withJSONObject: collection, options: JSONSerialization.WritingOptions.prettyPrinted) else {
					return ""
				}

				let string = String(data: data, encoding: .utf8)
				return string!

			default:
				debugPrint("Έχεις κάνει μαλακία")
				return ""
		}
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

	/// Checks the HTTP code status for validity.
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
