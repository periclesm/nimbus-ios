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

	//MARK: - Get Data Classes --
	
	@MainActor class func asyncData() async {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig(HTTPMethod: .GET, url: DataAPI.cloudURL, headers: headers)
		
		let response = await Networker.asyncData(config: config)
		if response.completed {
			//Decode data
			if let cloudData: CloudResults = NetData.decodeJSON(responseData: response.data as? Data) {
				//Add data to RealmDB
				do {
					try Database.shared.ops.insertCollection(dataList: cloudData.results)
				} catch {
					assert(true, "Send a RealmDB error")
				}
			}
		}
	}
}
