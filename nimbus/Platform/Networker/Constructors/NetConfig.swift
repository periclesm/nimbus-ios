//
//  NetObject.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation

/// A class object containing the data and additional information to construct the call's request.
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
    
    var identifier: String = NetUtilities.Identifier()
	var function: NetworkerFunction = NetworkerFunction.JSON
    
    var HTTPMethod: NetworkerHTTPMethod = .GET
    var caching: URLRequest.CachePolicy = .useProtocolCachePolicy
    var timeout: TimeInterval = 30
    
    var url: URL?
    var headers: Dictionary<String,String>? = [:]
	var body: Data? = nil

	/// To be implemented
    var sender: AnyObject?


	/// Constructor init function for the `NetConfig` object.
	/// - Parameters:
	///   - requestURL: The request URL. Note: If it's nil, it will throw later. Make sure you pass a valid URL.
	///   - requestHeaders: The headers to be used in the request as `Dictionary`. `NetAgent` will format each header to the required format.
	///   - requestBody: The request body as `Data`
	///   - requestTimeout: Time is seconds to wait until the request times out. Value is `TimeInterval` (`Double`)
	///   - requestFunction: Determines the type of `NetResponse` data. Value is `NetworkerFunction` enum.
	///   - requestMethod: The http method (`GET`, `POST`, etc). Value is NetworkerHTTPMethod enum.
	///   - requestCaching: The caching policy for the request. Value is the standard `CachePolicy` from `URLRequest`
	/// - Returns: A `NetConfig` instance.
	class func initWithConfig(requestURL: URL,
							  requestHeaders: Dictionary<String, String>? = nil,
							  requestBody: Data? = nil,
							  requestTimeout: TimeInterval? = 30,
							  requestFunction: NetworkerFunction? = .JSON,
							  requestMethod: NetworkerHTTPMethod? = .GET,
							  requestCaching: URLRequest.CachePolicy? = .useProtocolCachePolicy,
							  sender: AnyObject? = nil) -> NetConfig {
        
        let config = NetConfig()
        
        config.url = requestURL
        
        if let headers = requestHeaders {
            config.headers = headers
        }
        
        if let body = requestBody {
            config.body = body
        }
        
        config.timeout = requestTimeout!
		config.function = requestFunction!
        config.HTTPMethod = requestMethod!
        config.caching = requestCaching!
        
        config.sender = sender
        
        //debugPrint("++ Config \(config.identifier) init ++")
        return config
    }
}
