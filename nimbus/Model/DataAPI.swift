//
//  DataAPI.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 29/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation

/// Provides the URL endpoints for the application's REST calls.
class DataAPI: NSObject {

	//MARK: - Endpoints --

	static var clAltitudeURL: URL {
		get {
			return URL(string: "https://stage.clfd.eu/nimbus/classes/cloudType")!
		}
	}

	static var clDetailURL: URL {
		get {
			return URL(string: "https://stage.clfd.eu/nimbus/classes/cloudDetail")!
		}
	}

	static var cloudURL: URL {
		get {
			return URL(string: "https://stage.clfd.eu/nimbus/classes/cloudList")!
		}
	}

	static var combinedDataURL: URL {
		get {
			return URL(string: "https://stage.clfd.eu/nimbus/classes/cloudList?include=detail&include=type")!
		}
	}


	//MARK: - Utilities --

	/// Provides the default headers for the app's REST calls. Any additional header should be added in the `Dictionary` returned by this function.
	class func getDefaultHeaders() -> Dictionary<String,String> {
		let headers = ["X-Parse-Application-Id": "Y6372R67Q2UCqCsWuCnD4YZ3ACEiiFxngF6WNqwE", "X-Parse-REST-API-Key": "LdJJnrhcCEiY8kRA3vAwg4sxT73LhQu84Efmv796"]
		return headers
	}


	/// Provides the body data for a REST call
	/// - Parameter bodyData: The content of the body as `String`
	/// - Returns: The body data to be used in URLRequest as a `Data` object (`UTF-8` encoding)
	class func getBody(bodyData: String) -> Data {
		let bodyString = bodyData
		return bodyString.data(using: .utf8)!
	}


	/// URL encodes a string
	/// - Parameter urlString: A `String` to be URL Encoded
	/// - Returns: The URL Encoded string.
	class func encodeURL(_ urlString: String) -> String {
		if !urlString.isEmpty {
			if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
				return encodedString
			}
		}

		return ""
	}
}
