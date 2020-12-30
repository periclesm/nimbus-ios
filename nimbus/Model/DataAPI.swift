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

class DataAPI: NSObject {

	//MARK: - Endpoints --

	static var cloudType: URL {
		get {
			return URL(string: "https://stage.clfd.eu/nimbus/classes/cloudType")!
		}
	}

	static var cloudDetail: URL {
		get {
			return URL(string: "https://stage.clfd.eu/nimbus/classes/cloudDetail")!
		}
	}

	static var cloudList: URL {
		get {
			return URL(string: "https://stage.clfd.eu/nimbus/classes/cloudList")!
		}
	}

	static var allCloudData: URL {
		get {
			return URL(string: "https://stage.clfd.eu/nimbus/classes/cloudList?include=detail&include=type")!
		}
	}


	//MARK: - Utilities --

	class func getDefaultHeaders() -> Dictionary<String,String> {
		let headers = ["X-Parse-Application-Id": "Y6372R67Q2UCqCsWuCnD4YZ3ACEiiFxngF6WNqwE", "X-Parse-REST-API-Key": "LdJJnrhcCEiY8kRA3vAwg4sxT73LhQu84Efmv796"]
		return headers
	}

	class func getBody(bodyData: String) -> Data {
		let bodyString = bodyData
		return bodyString.data(using: .utf8)!
	}

	class func encodeURL(_ urlString: String) -> String {
		if let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
			return encodedString
		}

		return ""
	}
}
