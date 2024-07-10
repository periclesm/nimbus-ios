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

enum NetworkerFunction {
	case json
	case image
	case data
}

struct NetConfig {
    enum HTTPMethod: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    enum cachingMethod: Int {
        case defaultCaching = 0
        case ignoreCached = 1
        case tryCached = 2
        case onlyCached = 3
    }
    
    var identifier: String = NetUtilities.Identifier()
    
    var HTTPMethod: HTTPMethod = .GET
    var caching: cachingMethod = .defaultCaching
    var timeout: TimeInterval = 30
    
    var url: URL!
    var headers: Dictionary<String,String>? = [:]
    var body: Data? = nil
    var sender: AnyObject?
}
