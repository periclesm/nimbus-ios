//
//  DatabaseTests.swift
//  nimbusTests
//
//  Created by Perikles Maravelakis on 28/2/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import XCTest
@testable import nimbus

class DatabaseTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }
	
	func testDatabaseInstance() throws {
		debugPrint("+++ Start Database")
		XCTAssertNotNil(Database.shared.db)
	}

}
