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

class NetConfig: NSObject, URLSessionDelegate {
    
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
    
    override init() {
        //debugPrint("++ Config \(identifier) init ++")
        super.init()
    }
    
    class func initWithConfig(requestURL: URL?,
                               requestHeaders: Dictionary<String, String>? = nil,
                               requestBody: Data? = nil,
                               requestTimeout: TimeInterval? = 30,
                               requestMethod: NetworkerHTTPMethod? = .GET,
                               requestCaching: NetworkerCachingMethod? = .defaultCaching,
                               sender: AnyObject? = nil) -> NetConfig {
        
        let config = NetConfig()
        
        guard let url = requestURL else {
            assert(true, "What exactly are you trying to accomplish with an empty URL????")
            return NetConfig() //will never return. Assert will stop exec.
        }
        
        config.url = url
        
        if let headers = requestHeaders {
            config.headers = headers
        }
        
        if let body = requestBody {
            config.body = body
        }
        
        config.timeout = requestTimeout!
        config.HTTPMethod = requestMethod!
        config.caching = requestCaching!
        
        config.sender = sender
        
        //debugPrint("++ Config \(config.identifier) init ++")
        return config
    }
}
