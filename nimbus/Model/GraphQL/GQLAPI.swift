//
//  GQLAPI.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 29/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation

class GQLAPI: NSObject {

	//MARK: - Endpoints --

	static var baseURL: URL {
		get {
			return URL(string: "https://stage.clfd.eu/nimbus_gql")!
		}
	}
}
