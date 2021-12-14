//
//  Networker.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation

/** The network wrapper classes handling network requests and responses.
 
 Depending on the function used, the following types are returned:
 + `Collection`: Array or Dictionary based on JSON data
 + `UIImage`: The image requested
 + `Data`: A `Data` object
 */
class Networker: NSObject {
	
	/// Called by classes outside the Networker wrapper to connect and fetch data from a REST API in JSON format. The JSON data will be parsed into swift collection (`Array` or `Dictionary`).
	/// - Parameters:
	///   - config: A `NetConfig` parameter object to be used in the call. See `NetConfig` documentation for details.
	///   - completion: Returns a `NetResponse` object containing the response of the call, data (if successful) and error messages (if not). See `NetResponse` documentation for details.
	class func getJSONData(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
		config.function = .JSON
		NetAgent.shared.getData(config: config) { (response) in
			completion(response)
		}
	}
	
	/// Called by classes outside the Networker wrapper to connect and fetch an image from a web resource. Returning object will contain a `UIImage` object.
	/// - Parameters:
	///   - config: A `NetConfig` parameter object to be used in the call. See `NetConfig` documentation for details.
	///   - completion: Returns a `NetResponse` object containing the response of the call, data (if successful) and error messages (if not). See `NetResponse` documentation for details.
	class func getImage(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
		config.function = .Image
		NetAgent.shared.getData(config: config) { (response) in
			completion(response)
		}
	}
	
	/// Called by classes outside the Networker wrapper to connect and fetch a data object. Returning object will contain a `Data` object.
	/// - Parameters:
	///   - config: A `NetConfig` parameter object to be used in the call. See `NetConfig` documentation for details.
	///   - completion: Returns a `NetResponse` object containing the response of the call, data (if successful) and error messages (if not). See `NetResponse` documentation for details.
	class func getData(config: NetConfig, completion: @escaping (NetResponse) -> ()) {
		config.function = .Data
		NetAgent.shared.getData(config: config) { (response) in
			completion(response)
		}
	}
	
	///Not yet implemented
	class func cancelCall(identifier: String, completion: @escaping (Bool) -> ()) {
		//tbd
	}
}
