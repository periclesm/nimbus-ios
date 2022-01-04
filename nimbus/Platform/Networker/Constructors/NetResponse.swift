//
//  NetResponse.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 29/12/2020.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation

/// A class object containing the data and additional information of the call's response.
class NetResponse: NSObject {
	
	var identifier: String = NetUtilities.Identifier()
	var completed: Bool = false
	var error: NSError? = nil
	var data: Any? = nil
	
	/// The `NetResponse` constructor.
	/// - Parameters:
	///   - identifier: A random/unique `String` to identify the call. The String is created automatically in `NetUtilities.Identifier()`
	///   - completed: A `Boolean` value indicating if the call has completed or not.
	///   - error: A `NSError` object containing information when and why the call has failed. Returns `nil` if the call is successful.
	///   - data: A variable-type object. It's type depends on the `NetworkerFunction` in `NetConfig` passed in Networker at the start of the call.
	/// - Returns: A `NetResponse` instance.
	class func constructResponse(identifier: String, completed: Bool = false, error: NSError? = nil, data: Any? = nil) -> NetResponse {
		
		let response = NetResponse()
		response.identifier = identifier
		response.completed = completed
		
		if let err = error {
			response.error = err
		}
		
		if let responseData = data {
			response.data = responseData
		}
		
		return response
	}
}
