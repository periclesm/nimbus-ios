//
//  AsyncNetworker.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 9/6/22.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class NetAsyncAwait: NSObject {
	
	func getData(config: NetConfig, function: NetworkerFunction) async -> NetResponse {
		if #available(iOS 15.0, *) {
			let request = NetParameters.createRequest(requestURL: config.url, config: config)
			var responseData: (Data, URLResponse)
			
			do {
				let session = NetParameters.createSession(config: config)
				responseData = try await session.data(for: request)
				guard (responseData.1 as? HTTPURLResponse)?.statusCode == 200 else {
					debugPrint("Response HTTP Code: \(String(describing: (responseData.1 as? HTTPURLResponse)?.statusCode))")
					///Must create error here
					return self.createResponse(data: nil, error: nil, identifier: config.identifier)
				}
				
				//Process Data
				let data = self.processData(data: responseData.0, function: function)
				return self.createResponse(data: data, error: nil, identifier: config.identifier)
				
			} catch {
				//URLSession Error
				debugPrint("Error fetching data \(error.localizedDescription)")
				return self.createResponse(data: nil, error: error as NSError, identifier: config.identifier)
			}
		}
		else {
			return NetResponse()
		}
	}
	
	private func processData(data: Data, function: NetworkerFunction) -> Any? {
		var content: Any?
		
		switch function {
		case .json:
			content = NetData.dataToJSON(data: data)
			
		case .image:
			content = UIImage(data: data)
			
		case .data:
			content = data
		}
		
		return content
	}
	
	private func createResponse(data: Any?, error: NSError?, identifier: String) -> NetResponse {
		var response: NetResponse
		
		if error == nil {
			response = NetResponse(identifier: identifier, completed: true, error: nil, data: data)
		}
		else {
			response = NetResponse(identifier: identifier, completed: false, error: error, data: nil)
		}
		
		return response
	}
}
