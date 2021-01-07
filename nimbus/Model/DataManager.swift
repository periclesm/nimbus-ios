//
//  DataManager.swift
//  nimbus
//
//  Created by Pericles Maravelakis on 29/12/20.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import Foundation

/// The class is performing the necessary functions to retrieve, map and store the data used in the app.
class DataManager: NSObject {

	//MARK: - Prefetch Classes --

	/// Called at app start, this function prefetches a set of predetermined data needed for the app to use during launch and first display.
	class func prefetchData(completion: @escaping (Bool) -> ()) {
		self.getCombinedData({(completed) in
			completion(completed)
		})
	}


	/**
	A specific set of functions are written below. These functions are per app (each app has different needs) and per call.
	Function combinations can be coded and usage may vary.
	In general, this section is unique to each app and its data and business rules.
	Once the data have been fetched and validated, they are sent in `DataMapper` to map them in the Realm DB tables.
	*/

	//MARK: - Get Data Classes --

	/// Fetches the combined data of Cloud, Alittide and Detail.
	class func getCombinedData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.combinedDataURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapper.mapCloudData(data: data)
				completion?(true)
				debugPrint("Fetch Combined Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
				completion?(false)
			}
		}
	}

	class func getAltitudeData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.clAltitudeURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapper.mapAltitudeData(data: data)
				completion?(true)
				debugPrint("Fetch Altitude Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
				completion?(false)
			}
		}
	}

	class func getDetailData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.clDetailURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapper.mapDetailData(data: data)
				completion?(true)
				debugPrint("Fetch Detail Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
				completion?(false)
			}
		}
	}

	class func getCloudData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.cloudURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapper.mapCloudData(data: data)
				completion?(true)
				debugPrint("Fetch Cloud Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
				completion?(false)
			}
		}
	}
}
