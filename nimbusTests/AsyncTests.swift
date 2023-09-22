//
//  AsyncTests.swift
//  nimbusTests
//
//  Created by Perikles Maravelakis on 11/6/22.
//	periclesm@cloudfields.net
//	Licensed under Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)
//	https://creativecommons.org/licenses/by-sa/4.0/
//

import XCTest
@testable import nimbus

class AsyncTests: XCTestCase {
	
	var timeout = 15
	var endpointURL = DataAPI.cloudURL

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testAsyncAPI() async throws {
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig(HTTPMethod: .GET, url: endpointURL, headers: headers)
		let response = await Networker.asyncData(config: config)
		XCTAssertNotNil(response.data)
		
		//map data
		let cloudData: CloudResults? = NetData.decodeJSON(responseData: response.data as? Data)
		XCTAssertNotNil(cloudData)
		
		//add data to database
		DispatchQueue.main.async {
			let success = RealmOperation.add(dataArray: cloudData?.results, updatePolicy: .modified)
			XCTAssertTrue(success)
		}
	}
	
	func testFailAsyncAPI() async throws {
		let failed_endpointURL = URL(string: "https://api.clfd.eu/nimbus")
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig(HTTPMethod: .GET, url: failed_endpointURL, headers: headers)
		let response = await Networker.asyncData(config: config)
		XCTAssertNil(response.data)
		
		//map data
		let cloudData: CloudResults? = NetData.decodeJSON(responseData: response.data as? Data)
		XCTAssertNil(cloudData)
		
		//add data to database
		DispatchQueue.main.async {
			let success = RealmOperation.add(dataArray: cloudData?.results, updatePolicy: .modified)
			XCTAssertFalse(success)
		}
	}
}
