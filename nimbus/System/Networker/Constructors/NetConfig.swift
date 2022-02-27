//
//  NetObject.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

struct NetConfig {
    
    enum NetworkerFunction {
        case JSON
        case Image
        case Data
    }
    
    enum NetworkerHTTPMethod: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"            //not yet implemented
        case DELETE = "DELETE"      //not yet implemented
        case OPTIONS = "OPTIONS"    //not yet implemented
    }
    
    enum NetworkerCachingMethod: Int {
        case defaultCaching = 0
        case ignoreCached = 1
        case tryCached = 2
        case onlyCached = 3
    }
    
    var identifier: String = NetUtilities.Identifier()
    
    var HTTPMethod: NetworkerHTTPMethod = .GET
    var caching: NetworkerCachingMethod = .defaultCaching
    var timeout: TimeInterval = 30
    
    var url: URL!
    var headers: Dictionary<String,String>? = [:]
    var body: Data? = nil
    var sender: AnyObject?
}
