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

	@objc dynamic var objectId: String = ""
	@objc dynamic var name: String = ""
	@objc dynamic var detail: String = ""

	//MARK: - DB Properies --

	override static func primaryKey() -> String? {
		return "objectId"
	}

	override static func indexedProperties() -> Array<String> {
		return ["name"]
	}

	override static func ignoredProperties() -> Array<String> {
		return []
	}
	
//	init(objectId: String = "", name: String = "", detail: String = "") {
//		self.objectId = objectId
//		self.name = name
//		self.detail = detail
//	}
//	
//	required init?(coder aDecoder: NSCoder) {
//		super.init()
//	}
}
