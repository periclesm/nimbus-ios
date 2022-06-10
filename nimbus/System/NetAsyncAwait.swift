//
//  AsyncNetworker.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 9/6/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import UIKit

class NetAsyncAwait: NSObject {
	
	func getData(config: NetConfig) async -> NetResponse {
		let request = NetAgent.sharedInstance.createRequest(requestURL: config.url, config: config)
		var responseData: (Data, URLResponse)
		
		do {
			let session = self.createSession(config: config)
			responseData = try await session.data(for: request)
			guard (responseData.1 as? HTTPURLResponse)?.statusCode == 200 else {
				debugPrint("Response HTTP Code: \(String(describing: (responseData.1 as? HTTPURLResponse)?.statusCode))")
				
				///Must create error here
				return self.createResponse(data: nil, error: nil, identifier: config.identifier)
			}
			
			return self.createResponse(data: responseData.0, error: nil, identifier: config.identifier)
		} catch {
			debugPrint("Error fetching image \(error.localizedDescription)")
			return self.createResponse(data: nil, error: error as NSError, identifier: config.identifier)
		}
	}
	
	private func createSession(config: NetConfig) -> URLSession {
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
	
	private func createResponse(data: Any?, error: NSError?, identifier: String) -> NetResponse {
		var response = NetResponse()
		response.identifier = identifier
		
		if error == nil {
			response.completed = true
			response.data = data
		}
		else {
			response.completed = false
			response.error = error
		}
		
		return response
	}
}
