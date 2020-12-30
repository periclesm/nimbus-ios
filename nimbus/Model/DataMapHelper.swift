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

	class func mapCloudType(data: Dictionary<AnyHashable,Any>) {
		var dataArray: Array<clType> = []

		if let results = data["results"] as? Array<Dictionary<String,Any>> {
			for object in results {
				let typeObject = clType.mapObject(object: object)
				dataArray.append(typeObject)
			}
		}

		if !dataArray.isEmpty {
			RealmOperation.add(dataArray: dataArray, updatePolicy: .modified)
		}
	}

	class func mapCloudDetail(data: Dictionary<AnyHashable,Any>) {
		if let results = data["results"] as? Array<Dictionary<String,Any>> {
			var dataArray: Array<clDetail> = []

			for object in results {
				let detailObject = clDetail.mapObject(object: object)
				dataArray.append(detailObject)
			}

			if !dataArray.isEmpty {
				RealmOperation.add(dataArray: dataArray, updatePolicy: .modified)
			}
		}
	}

	class func mapCloudList(data: Dictionary<AnyHashable,Any>) {
		guard let results = data["results"] as? Array<Dictionary<String,Any>>  else {
			return
		}

		var dataArray: Array<clList> = []

		for object in results {
			let listObject = clList.mapObject(object: object)
			dataArray.append(listObject)
		}

		if !dataArray.isEmpty {
			RealmOperation.add(dataArray: dataArray, updatePolicy: .modified)
		}
	}
}
