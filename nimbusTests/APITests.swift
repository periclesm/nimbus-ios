//
//  ModelTests.swift
//  nimbusTests
//
//  Created by Perikles Maravelakis on 28/2/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import XCTest
@testable import nimbus

class APITests: XCTestCase {
	
	var timeout = 15
	var endpointURL = DataAPI.cloudURL

    override func setUpWithError() throws {
		
    }

    override func tearDownWithError() throws {
        
    }
	
	func testEndpoint() throws {
		debugPrint("+++ API Tests")
		XCTAssertNotNil(endpointURL)
	}
	
	func testAPI() throws {
		var responseData: Data?
		
		let operationWait = expectation(description: "Fetching API Data")
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig(HTTPMethod: .GET, url: endpointURL, headers: headers)

		Networker.getData(config: config) { response in
			XCTAssertTrue(response.completed, "API Network call completion")
			
			responseData = response.data as? Data
			operationWait.fulfill()
		}
		
		waitForExpectations(timeout: TimeInterval(self.timeout), handler: nil)
		XCTAssertNotNil(responseData)
		
		//map data
		let cloudData: CloudResults? = NetData.decodeJSON(responseData: responseData)
		XCTAssertNotNil(cloudData)
		
		//add data to database
		let success = RealmOperation.add(dataArray: cloudData?.results, updatePolicy: .modified)
		XCTAssertTrue(success)
		//RealmOperation needs to be more testable...
	}
	
	func testAPIFailed() throws {
		var responseData: Data?
		
		let operationWait = expectation(description: "Fetching API Data")
		let failed_endpointURL = URL(string: "https://stage.clfd.eu/nimbus")
		let headers = DataAPI.getDefaultHeaders()
		let config = NetConfig(HTTPMethod: .GET, url: failed_endpointURL, headers: headers)
		
		Networker.getData(config: config) { response in
			XCTAssertFalse(response.completed, "API Network call completion")
			
			responseData = response.data as? Data
			operationWait.fulfill()
		}
		
		waitForExpectations(timeout: TimeInterval(self.timeout), handler: nil)
		XCTAssertNil(responseData)
		
		//map data
		let cloudData: CloudResults? = NetData.decodeJSON(responseData: responseData)
		XCTAssertNil(cloudData)
		
		//add data to database
		let success = RealmOperation.add(dataArray: cloudData?.results, updatePolicy: .modified)
		XCTAssertFalse(success)
		//RealmOperation needs to be more testable...
	}
}
