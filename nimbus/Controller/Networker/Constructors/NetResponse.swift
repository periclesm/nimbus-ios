//
//  NetResponse.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 02/08/2017.
//  Copyright © 2017 Pericles Maravelakis. All rights reserved.
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
