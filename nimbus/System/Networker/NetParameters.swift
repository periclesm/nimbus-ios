//
//  NetParameters.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 11/6/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import UIKit

class NetParameters: NSObject {

	class func createRequest(requestURL: URL, config: NetConfig) -> URLRequest {
		var request = URLRequest(url: requestURL)
		request.httpBody = config.body
		request.timeoutInterval = config.timeout
		request.httpMethod = config.HTTPMethod.rawValue
		request.cachePolicy = URLRequest.CachePolicy.init(rawValue: UInt(config.caching.rawValue))!
		request.httpShouldUsePipelining = true
		request.allowsCellularAccess = true
		
		if #available(iOS 13.0, *) {
			request.allowsConstrainedNetworkAccess = true
			request.allowsExpensiveNetworkAccess = true
		}
		
		// Headers
		if let headerData = config.headers {
			for headerName in headerData.keys {
				let headerValue: String = (config.headers?[headerName]!)!
				request.addValue(headerValue, forHTTPHeaderField: headerName)
			}
		}
		
		return request
	}
	
	class func createSession(config: NetConfig) -> URLSession {
		let configuration = URLSessionConfiguration.default
		
		configuration.timeoutIntervalForRequest = config.timeout
		configuration.timeoutIntervalForResource = config.timeout
		configuration.httpAdditionalHeaders = config.headers
		configuration.waitsForConnectivity = true
		configuration.isDiscretionary = true
		configuration.httpShouldUsePipelining = true
		configuration.httpShouldSetCookies = false
		configuration.multipathServiceType = .handover
		
		let session = URLSession(configuration: configuration)
		return session
	}
}
