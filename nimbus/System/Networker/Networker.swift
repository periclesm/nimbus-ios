//
//  Networker.swift
//  SwiftNetworker
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import UIKit

class Networker: NSObject {
	
	//MARK: - Async/Await iOS 15+
	
	class func getAsyncJSON(config: NetConfig) async -> NetResponse {
		return await NetAsyncAwait().getData(config: config, function: .json)
	}
	
	class func asyncImage(config: NetConfig) async -> NetResponse {
		return await NetAsyncAwait().getData(config: config, function: .image)
	}
	
	class func asyncData(config: NetConfig) async -> NetResponse {
		return await NetAsyncAwait().getData(config: config, function: .data)
	}
	
	//MARK: - NSOperation iOS 14- -- Deprecated
	
	class func getJSONData(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
		NetAgent.sharedInstance.getData(config: config, function: .json) { (response) in
			completion(response)
		}
	}
	
	class func getImage(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
		NetAgent.sharedInstance.getData(config: config, function: .image) { (response) in
			completion(response)
		}
	}
	
	class func getData(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
		NetAgent.sharedInstance.getData(config: config, function: .data) { (response) in
			completion(response)
		}
	}
}
