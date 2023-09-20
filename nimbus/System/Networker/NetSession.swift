//
//  NetParameters.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 11/6/22.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class NetSession: NSObject {

	class func request(requestURL: URL, config: NetConfig) -> URLRequest {
		var request = URLRequest(url: requestURL)
		request.httpBody = config.body
		request.httpMethod = config.HTTPMethod.rawValue
		request.cachePolicy = URLRequest.CachePolicy.init(rawValue: UInt(config.caching.rawValue))!
		
		// Headers
		if let headerData = config.headers {
			for headerName in headerData.keys {
				let headerValue: String = (config.headers?[headerName]!)!
				request.addValue(headerValue, forHTTPHeaderField: headerName)
			}
		}
		
		return request
	}
	
	class func session(config: NetConfig, delegate: URLSessionDelegate? = nil) -> URLSession {
		let configuration = URLSessionConfiguration.default
		
		configuration.timeoutIntervalForRequest = config.timeout
		configuration.timeoutIntervalForResource = config.timeout
		configuration.httpAdditionalHeaders = config.headers
		configuration.waitsForConnectivity = true
		configuration.isDiscretionary = true
		configuration.allowsCellularAccess = true
		configuration.httpShouldUsePipelining = true
		//configuration.multipathServiceType = .handover
		
		let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: .main)
		return session
	}
}
