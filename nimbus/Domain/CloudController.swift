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

class CloudController: NSObject {

	class func getCloudListCount() -> Int {
		return Database.shared.db.objects(Cloud.self).count
	}

	class func getCloud(objectId: String) -> Cloud? {
		let predicate = NSPredicate(format: "objectId = %@", objectId)
		let cloud = Database.shared.db.objects(Cloud.self).filter(predicate)
		if !cloud.isEmpty {
			return cloud.first
		}

		return nil
	}

	class func getListData(sortBy: String, ascending: Bool = true) -> Array<Cloud> {
		let data = Database.shared.db.objects(Cloud.self).sorted(byKeyPath: sortBy, ascending: ascending)
		return Array(data)
	}

	class func filterListData(filter: NSPredicate, sortBy: String, ascending: Bool = true) -> Array<Cloud> {
		let data = Database.shared.db.objects(Cloud.self).filter(filter).sorted(byKeyPath: sortBy, ascending: ascending)
		return Array(data)
	}

	class func getImageURL(for objectId: String) -> URL? {
		let cloud = self.getCloud(objectId: objectId)

		if let imageURL = cloud?.detail?.image {
			return URL(string: imageURL)
		}

		return nil
	}

	class func getWikiURL(for objectId: String) -> URL? {
		let cloud = self.getCloud(objectId: objectId)

		if let imageURL = cloud?.detail?.wiki {
			return URL(string: imageURL)
		}

		return nil
	}
}
