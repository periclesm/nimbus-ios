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
		self.getTypeData()
		self.getDetailData()
		self.getListData()
	}

	//MARK: - Get Data Classes --

	class func getAllData() {
		let headers = DataAPI.getDefaultHeaders()
		let body = DataAPI.getBody(bodyData: "")
		let config = NetConfig.initWithConfig(requestURL: GQLAPI.baseURL, requestHeaders: headers, requestBody: body, requestMethod: .POST)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				debugPrint(data)
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
			}
		}
	}

	class func getTypeData() {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.cloudType, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapper.mapCloudType(data: data)
				debugPrint("Fetch Type Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
			}
		}
	}

	class func getDetailData() {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.cloudDetail, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapper.mapCloudDetail(data: data)
				debugPrint("Fetch Detail Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
			}
		}
	}

	class func getListData() {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig.initWithConfig(requestURL: DataAPI.cloudList, requestHeaders: headers, requestMethod: .GET)

		Networker.getJSONData(config: config) { (response) in
			if response.completed {
				let data = response.data as! Dictionary<AnyHashable,Any>
				DataMapper.mapCloudList(data: data)
				debugPrint("Fetch List Data complete")
			}
			else {
				debugPrint(response.error?.localizedDescription ?? "error")
			}
		}
	}
}
