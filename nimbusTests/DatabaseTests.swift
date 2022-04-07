//
//  DatabaseTests.swift
//  nimbusTests
//
//  Created by Perikles Maravelakis on 28/2/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import XCTest
@testable import nimbus
import RealmSwift

class DatabaseTests: XCTestCase {
	
	var cloudId = "JwYJf2rVyx"
	var fail_cloudId = "wYJf2rVy"

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
	
	func testDatabaseInstance() throws {
		debugPrint("+++ Start Database")
		XCTAssertNotNil(Database.shared.db)
	}
	
	func testGetAllClouds() throws {
		let clouds = CloudController.getListData(sortBy: "order")
		XCTAssertFalse(clouds.isEmpty)
	}
	
	func testGetCloud() throws {
		let cloud = CloudController.getCloud(objectId: cloudId)
		XCTAssertNotNil(cloud)
		
		let failed_cloud = CloudController.getCloud(objectId: fail_cloudId)
		XCTAssertNil(failed_cloud)
	}
	
	func testGetCloudImageURL() throws {
		let cloudURL = CloudController.getImageURL(for: cloudId)
		XCTAssertNotNil(cloudURL)
		
		let failed_cloudURL = CloudController.getImageURL(for: fail_cloudId)
		XCTAssertNil(failed_cloudURL)
		
	}
	
	func testGetCloudWikiURL() throws {
		let cloudWiki = CloudController.getWikiURL(for: cloudId)
		XCTAssertNotNil(cloudWiki)
		
		let failed_cloudWiki = CloudController.getWikiURL(for: fail_cloudId)
		XCTAssertNil(failed_cloudWiki)
	}
	
	func testFetchCloudImage() throws {
		var image: UIImage?
		let cloudURL = CloudController.getImageURL(for: cloudId)
		XCTAssertNotNil(cloudURL)
		
		let operationWait = expectation(description: "Fetching Image Data")
		let config = NetConfig(HTTPMethod: .GET, url: cloudURL)
		
		Networker.getImage(config: config) { response in
			XCTAssertTrue(response.completed, "Image Network call completion")
			
			image = response.data as? UIImage
			operationWait.fulfill()
		}
		
		waitForExpectations(timeout: 30, handler: nil)
		XCTAssertNotNil(image)
	}
	
	func testFetchCloudImageFailed() throws {
		var image: UIImage?
		let cloudURL = CloudController.getImageURL(for: fail_cloudId)
		XCTAssertNil(cloudURL)
		
		let operationWait = expectation(description: "Fetching Image Data")
		let config = NetConfig(HTTPMethod: .GET, url: cloudURL)
		
		Networker.getImage(config: config) { response in
			XCTAssertFalse(response.completed, "Image Network call completion")
			
			image = response.data as? UIImage
			operationWait.fulfill()
		}
		
		waitForExpectations(timeout: 30, handler: nil)
		XCTAssertNil(image)
	}

}
