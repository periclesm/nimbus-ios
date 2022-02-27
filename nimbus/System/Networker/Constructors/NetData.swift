//
//  NetData.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class NetData: NSObject {
	
	class func decodeJSON<T: Decodable>(responseData: Data?) -> T? {
		
		guard let data = responseData else {
			return nil
		}
		
		do {
			return try JSONDecoder().decode(T.self, from: data)
		}
		catch {
			debugPrint("Parsing error: \(error.localizedDescription)")
			return nil
		}
	}
    
    class func dataToJSON(data: Data) -> AnyObject {
        guard let returningData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) else {
            return NSDictionary.init()
        }
        
        return returningData as AnyObject
    }
    
}
