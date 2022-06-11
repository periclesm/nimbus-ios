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
	
	///iOS 15+
	class func asyncData() async {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig(HTTPMethod: .GET, url: DataAPI.cloudURL, headers: headers)
		
		let response = await Networker.asyncData(config: config)
		if response.completed {
			//Decode data
			if let cloudData: CloudResults? = NetData.decodeJSON(responseData: response.data as? Data) {
				//Add data to RealmDB
				DispatchQueue.main.async {
					let completed = RealmOperation.add(dataArray: cloudData?.results, updatePolicy: .modified)
					
					if !completed {
						assert(true, "Send a RealmDB error")
					}
				}
			}
		}
	}
	
	///iOS 14- -- Deprecated
	class func getData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig(HTTPMethod: .GET, url: DataAPI.cloudURL, headers: headers)
		
		Networker.getData(config: config) { response in
			if response.completed {
				//Decode data
				if let cloudData: CloudResults? = NetData.decodeJSON(responseData: response.data as? Data) {
					//Add data to RealmDB
					let completed = RealmOperation.add(dataArray: cloudData?.results, updatePolicy: .modified)
					
					if !completed {
						assert(true, "Send a RealmDB error")
						completion?(false)
					}
				}
				else {
					completion?(false)
				}
			}
			
			completion?(response.completed)
		}
	}
}
