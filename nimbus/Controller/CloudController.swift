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

/**
Contains a set of functions that retrieve, prepare and deliver data from the lower Model to the higher UI layer.
All functions here are per-app and depended to the Application and Business Logic of the app.
Below is a sample set of functions for the Cloud-related data operations in the Nimbus app.
The more complex the application, the greater the number of functions and their complexity.
*/
class CloudController: NSObject {

	class func getCloudListCount() -> Int {
		return RealmDatabase.shared.db.objects(Cloud.self).count
	}

	class func getCloud(objectId: String) -> Cloud? {
		let predicate = NSPredicate(format: "objectId = %@", objectId)
		let cloud = RealmDatabase.shared.db.objects(Cloud.self).filter(predicate)
		if !cloud.isEmpty {
			return cloud.first
		}

		return nil
	}

	class func getCloudData(sortBy: String, ascending: Bool = true) -> Array<Cloud> {
		let results = RealmQuery.sort(rObject: Cloud.self, sortAttribute: sortBy, ascending: ascending)
		return Array(results) as! Array<Cloud>
	}

	class func filterListData(filter: NSPredicate, sortBy: String, ascending: Bool = true) -> Array<Cloud> {
		let results = RealmQuery.filterAndSort(rObject: Cloud.self, predicate: filter, sortAttribute: sortBy, ascending: ascending)
		return Array(results) as! Array<Cloud>
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
