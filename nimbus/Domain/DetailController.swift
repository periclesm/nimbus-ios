//
//  DetailController.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 30/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation
import RealmSwift

class DetailController: NSObject {

	class func getCloudDetailCount() -> Int {
		return Database.shared.db.objects(CloudDetail.self).count
	}

	class func getCloudDetail(objectId: String) -> CloudDetail? {
		let predicate = NSPredicate(format: "objectId = %@", objectId)
		let cloud = Database.shared.db.objects(CloudDetail.self).filter(predicate)
		if !cloud.isEmpty {
			return cloud.first
		}

		return nil
	}

	class func getDetailData(orderBy: String, ascending: Bool = true) {

	}

}
