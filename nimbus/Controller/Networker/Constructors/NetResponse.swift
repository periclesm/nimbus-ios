//
//  NetResponse.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class NetResponse: NSObject {
    
    var identifier: String = ""
    var completed: Bool = false
    var error: NSError? = nil
    var data: Any? = nil
    
    class func constructResponse(identifier: String? = nil, completed: Bool = false, error: NSError? = nil, data: Any? = nil) -> NetResponse {
        
        let response = NetResponse()
        
        guard let ident = identifier else {
            assert(true, "You must provide an identifier")
            return NetResponse()
        }
        
        response.identifier = ident
        response.completed = completed
        
        if let err = error {
            response.error = err
        }
        
        if let responseData = data {
            response.data = responseData
        }
        
        //debugPrint("++ Response \(response.identifier) init ++")
        return response
    }
}
