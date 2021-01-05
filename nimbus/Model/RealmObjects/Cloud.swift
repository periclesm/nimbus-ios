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

	class func mapObject(dataObject: Dictionary<AnyHashable,Any>) -> Cloud {
		let clObject = Cloud()

		clObject.objectId = dataObject["objectId"] as? String ?? ""
		clObject.order = dataObject["order"] as? Int ?? 0
		clObject.initials = dataObject["initials"] as? String ?? ""
		clObject.name = dataObject["name"] as? String ?? ""
		clObject.excerpt = dataObject["excerpt"] as? String ?? ""

		if let detailData = dataObject["detail"] as? Dictionary<AnyHashable,Any> {
			let detailObject = CloudDetail.mapObject(dataObject: detailData)
			//add to database
			RealmOperation.add(detailObject)
			clObject.detail = detailObject
		}

		if let typeData = dataObject["type"] as? Dictionary<AnyHashable,Any> {
			let typeObject = CloudAltitude.mapObject(dataObject: typeData)
			//add to database
			RealmOperation.add(typeObject)
			clObject.type = typeObject
		}

		return clObject
	}
}
