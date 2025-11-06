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
		
	class func getAsyncJSON(config: NetConfig) async -> NetResponse {
		return await NetAgent.shared.getData(config: config, function: .json)
	}
	
	class func asyncImage(config: NetConfig) async -> NetResponse {
		return await NetAgent.shared.getData(config: config, function: .image)
	}
	
	class func asyncData(config: NetConfig) async -> NetResponse {
		return await NetAgent.shared.getData(config: config, function: .data)
	}
}
