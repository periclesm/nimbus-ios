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

	class func prefetchData(completion: @escaping (Bool) -> ()) {		
		self.getData { completed in
			completion(completed)
		}
	}

	//MARK: - Get Data Classes --
	
	class func getData(_ completion: ((Bool) -> Void)? = nil) {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig(HTTPMethod: .GET, url: DataAPI.cloudURL, headers: headers)
		
		Networker.getData(config: config) { response in
			if response.completed {
				//Decode data
				if let cloudData: CloudResults? = NetData.decodeJSON(responseData: response.data as? Data) {
					//Add data to RealmDB
					RealmOperation.add(dataArray: cloudData?.results, updatePolicy: .modified)
					completion?(response.completed)
				}
				else {
					completion?(false)
				}
			}
			else {
				completion?(response.completed)
			}
		}
	}
}
