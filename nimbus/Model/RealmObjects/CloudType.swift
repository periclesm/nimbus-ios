//
//  CloudType.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 28/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

class CloudType: Object, Codable {

	@Persisted (primaryKey: true) var objectId: String = ""
	@Persisted (indexed: true) var name: String = ""
	@Persisted var detail: String = ""

//	override static func primaryKey() -> String? {
//		return "objectId"
//	}

//	override static func indexedProperties() -> Array<String> {
//		return ["name"]
//	}
//
//	override static func ignoredProperties() -> Array<String> {
//		return []
//	}
}
