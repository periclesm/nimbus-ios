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

/// This class maps the REST API data into the Realm Database for use within the app.
class DataMapper: NSObject {
	
	
	/// Maps the Cloud API data through the `map` object function into Realm DB
	class func mapCloudData(data: Dictionary<AnyHashable,Any>) {
		guard let results = data["results"] as? Array<Dictionary<String,Any>>  else {
			return
		}
		
		var dataArray: Array<Cloud> = []
		
		for object in results {
			let listObject = Cloud.mapObject(dataObject: object)
			dataArray.append(listObject)
		}
		
		if !dataArray.isEmpty {
			RealmOperation.add(objectArray: dataArray, updatePolicy: .modified)
		}
	}
	
	/// Maps the Altitude API data through the `map` object function into Realm DB
	class func mapAltitudeData(data: Dictionary<AnyHashable,Any>) {
		var dataArray: Array<CloudAltitude> = []
		
		if let results = data["results"] as? Array<Dictionary<String,Any>> {
			for object in results {
				let altitudeObject = CloudAltitude.mapObject(dataObject: object)
				dataArray.append(altitudeObject)
			}
		}
		
		if !dataArray.isEmpty {
			RealmOperation.add(objectArray: dataArray, updatePolicy: .modified)
		}
	}
	
	/// Maps the Cloud Detail API data through the `map` object function into Realm DB
	class func mapDetailData(data: Dictionary<AnyHashable,Any>) {
		if let results = data["results"] as? Array<Dictionary<String,Any>> {
			var dataArray: Array<CloudDetail> = []
			
			for object in results {
				let detailObject = CloudDetail.mapObject(dataObject: object)
				dataArray.append(detailObject)
			}
			
			if !dataArray.isEmpty {
				RealmOperation.add(objectArray: dataArray, updatePolicy: .modified)
			}
		}
	}
	
	
}
