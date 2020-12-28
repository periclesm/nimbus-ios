//
//  CloudList.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 28/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

class CloudLists: Object {

	@objc dynamic var objectId: String = ""
	@objc dynamic var order: Int = 0
	@objc dynamic var initials: String = ""
	@objc dynamic var name: String = ""
	@objc dynamic var detail: String = ""
	@objc dynamic var type: String = ""


	//MARK: - DB Properies --

	override static func primaryKey() -> String? {
		return "objectId"
	}

	override static func indexedProperties() -> [String] {
		return ["order", "name", "initials", "type"]
	}

	override static func ignoredProperties() -> [String] {
		return []
	}


	//MARK: - Map Data --

	class func mapData() {

	}
}
