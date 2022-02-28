//
//  TypeController.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 30/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

class AltitudeController: NSObject {

	class func getTypeCount() -> Int {
		return Database.shared.db.objects(CloudType.self).count
	}

	class func getCloudType(objectId: String) -> CloudType? {
		let predicate = NSPredicate(format: "objectId = %@", objectId)
		let cloud = Database.shared.db.objects(CloudType.self).filter(predicate)
		if !cloud.isEmpty {
			return cloud.first
		}

		return nil
	}

	class func getTypeData(orderBy: String, ascending: Bool = true) {

	}

}
