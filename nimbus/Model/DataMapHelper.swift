//
//  DataMapper.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 29/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import RealmSwift

class DataMapHelper: NSObject {

	/// Three different ways to check against nil... Why? Because we can!

	class func mapAltitudeData(data: Dictionary<AnyHashable,Any>) {
		var dataArray: Array<CloudAltitude> = []

		if let results = data["results"] as? Array<Dictionary<String,Any>> {
			for object in results {
				let typeObject = CloudAltitude.mapObject(object: object)
				dataArray.append(typeObject)
			}
		}

		if !dataArray.isEmpty {
			RealmOperation.add(dataArray: dataArray, updatePolicy: .modified)
		}
	}

	class func mapDetailData(data: Dictionary<AnyHashable,Any>) {
		if let results = data["results"] as? Array<Dictionary<String,Any>> {
			var dataArray: Array<CloudDetail> = []

			for object in results {
				let detailObject = CloudDetail.mapObject(object: object)
				dataArray.append(detailObject)
			}

			if !dataArray.isEmpty {
				RealmOperation.add(dataArray: dataArray, updatePolicy: .modified)
			}
		}
	}

	class func mapCloudData(data: Dictionary<AnyHashable,Any>) {
		guard let results = data["results"] as? Array<Dictionary<String,Any>>  else {
			return
		}

		var dataArray: Array<Cloud> = []

		for object in results {
			let listObject = Cloud.mapObject(object: object)
			dataArray.append(listObject)
		}

		if !dataArray.isEmpty {
			RealmOperation.add(dataArray: dataArray, updatePolicy: .modified)
		}
	}
}
