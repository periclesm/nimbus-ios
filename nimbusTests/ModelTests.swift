//
//  ModelTests.swift
//  nimbusTests
//
//  Created by Perikles Maravelakis on 28/2/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import XCTest
@testable import nimbus
@testable import Pods_nimbus

class ModelTests: XCTestCase {
	
	var timeout = 15
	var config: NetConfig?
	var endpointURL: URL?

    override func setUpWithError() throws {
		self.endpointURL = DataAPI.cloudURL
		let headers = DataAPI.getDefaultHeaders()
		self.config = NetConfig(HTTPMethod: .GET, url: endpointURL, headers: headers)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func testEndpoint() throws {
		XCTAssertNotNil(endpointURL)
	}
	
	func testAPI() throws {
		var responseData: Data?
		
		guard let config = self.config else {
			XCTAssertNotNil(self.config)
			return
		}
		
		let promise = expectation(description: "Fetching API Data")
		
		Networker.getData(config: config) { response in
			XCTAssertTrue(response.completed, "Network call completion")
			
			responseData = response.data as? Data
			
			promise.fulfill()
		}
		
		waitForExpectations(timeout: TimeInterval(self.timeout), handler: nil)

		XCTAssertNotNil(responseData)
		
		//map data
		let cloudData: CloudResults? = NetData.decodeJSON(responseData: responseData)
		XCTAssertNotNil(cloudData)
		
		//add data to database
		RealmOperation.add(dataArray: cloudData?.results, updatePolicy: .modified)
		//RealmOperation needs to be more testable...
	}
}
