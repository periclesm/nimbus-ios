//
//  ListController.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 30/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

class ListController: NSObject {

	class func getListCount() -> Int {
		return Database.shared.db.objects(clList.self).count
	}

	class func getCloud(objectId: String) -> clList? {
		let predicate = NSPredicate(format: "objectId = %@", objectId)
		let cloud = Database.shared.db.objects(clList.self).filter(predicate)
		if !cloud.isEmpty {
			return cloud.first
		}

		return nil
	}

	class func getListData(sortBy: String, ascending: Bool = true) -> Array<clList> {
		let data = Database.shared.db.objects(clList.self).sorted(byKeyPath: sortBy, ascending: ascending)
		return Array(data)
	}

	class func filterListData(filter: NSPredicate, sortBy: String, ascending: Bool = true) -> Array<clList> {
		let data = Database.shared.db.objects(clList.self).filter(filter).sorted(byKeyPath: sortBy, ascending: ascending)
		return Array(data)
	}
}
