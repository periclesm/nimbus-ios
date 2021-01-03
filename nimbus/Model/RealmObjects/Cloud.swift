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

class Cloud: Object {

	@objc dynamic var objectId: String = ""
	@objc dynamic var order: Int = 0
	@objc dynamic var initials: String = ""
	@objc dynamic var name: String = ""
	@objc dynamic var excerpt: String = ""
	@objc dynamic var detail: CloudDetail? = nil
	@objc dynamic var type: CloudAltitude? = nil


	//MARK: - DB Properies --

	override static func primaryKey() -> String? {
		return "objectId"
	}

	override static func indexedProperties() -> [String] {
		return ["order", "name", "initials"]
	}

	override static func ignoredProperties() -> [String] {
		return []
	}


	//MARK: - Map Data --

	class func mapObject(object: Dictionary<AnyHashable,Any>) -> Cloud {
		let listObject = Cloud()

		listObject.objectId = object["objectId"] as? String ?? ""
		listObject.order = object["order"] as? Int ?? 0
		listObject.initials = object["initials"] as? String ?? ""
		listObject.name = object["name"] as? String ?? ""
		listObject.excerpt = object["excerpt"] as? String ?? ""

		if let details = object["detail"] as? Dictionary<AnyHashable,Any> {
			let detailObject = CloudDetail.mapObject(object: details)
			//add to database
			RealmOperation.add(detailObject)
			listObject.detail = detailObject
		}

		if let typeData = object["type"] as? Dictionary<AnyHashable,Any> {
			let typeObject = CloudAltitude.mapObject(object: typeData)
			//add to database
			RealmOperation.add(typeObject)
			listObject.type = typeObject
		}

		return listObject
	}
}
