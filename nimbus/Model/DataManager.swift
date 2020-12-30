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

class DataManager: NSObject {

	//MARK: - Prefetch Classes --

	class func prefetchData() {
		self.getCombinedData()
	}

	//MARK: - Get Data Classes --

	class func getCombinedData() {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.combinedDataURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapHelper.mapCloudData(data: data)
				debugPrint("Fetch All Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
			}
		}
	}

	class func getAltitudeData() {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.clAltitudeURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapHelper.mapAltitudeData(data: data)
				debugPrint("Fetch Type Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
			}
		}
	}

	class func getDetailData() {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.clDetailURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapHelper.mapDetailData(data: data)
				debugPrint("Fetch Detail Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
			}
		}
	}

	class func getCloudData() {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.cloudURL, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapHelper.mapCloudData(data: data)
				debugPrint("Fetch List Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
			}
		}
	}
}
