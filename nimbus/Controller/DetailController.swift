//
//  DetailController.swift
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
Below is a sample set of functions for the CloudDetail-related data operations in the Nimbus app.
The more complex the application, the greater the number of functions and their complexity.
*/
class DetailController: NSObject {

	class func getCloudDetailCount() -> Int {
		return RealmDatabase.shared.db.objects(CloudDetail.self).count
	}

	class func getCloudDetail(objectId: String) -> CloudDetail? {
		let predicate = NSPredicate(format: "objectId = %@", objectId)
		let cloud = RealmDatabase.shared.db.objects(CloudDetail.self).filter(predicate)
		if !cloud.isEmpty {
			return cloud.first
		}

		return nil
	}
}
