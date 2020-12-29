//
//  NetData.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 03/08/2017.
//  Copyright © 2017 Pericles Maravelakis. All rights reserved.
//

import UIKit

class NetData: NSObject {
    
    class func DataToJSON(data: Data) -> AnyObject {
        guard let returningData = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.init(rawValue: 0)) else {
            return NSDictionary.init()
        }
        
        return returningData as AnyObject
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

}
