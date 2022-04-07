//
//  RealmOperationsTests.swift
//  nimbusTests
//
//  Created by Perikles Maravelakis on 1/3/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import XCTest
@testable import nimbus

class RealmOperationsTests: XCTestCase {
	
	let dummyId = "htWksjrYD"
	let dummyCloud = Cloud()

    override func setUpWithError() throws {
		dummyCloud.objectId = dummyId
		dummyCloud.name = "Dummy Cloud"
		dummyCloud.order = 999
		dummyCloud.initials = "Dc"
    }

    override func tearDownWithError() throws {
       
    }
	
	func testAddDelete() throws {
		XCTAssertNotNil(dummyCloud)
		
		let successAdd = RealmOperation.add(dummyCloud, updatePolicy: .modified)
		XCTAssertTrue(successAdd)
		
		let successDelete = RealmOperation.delete(dataObject: dummyCloud)
		XCTAssertTrue(successDelete)
	}
}
