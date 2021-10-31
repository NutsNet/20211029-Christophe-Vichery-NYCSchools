//
//  JpmUxProtoTests.swift
//  JpmUxProtoTests
//
//  Created by Christophe Vichery on 10/31/21.
//

import XCTest
@testable import JpmUxProto

class JpmUxProtoTests: XCTestCase {
    
    var sutApi: Api!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        try super.setUpWithError()
        sutApi = Api.share
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        sutApi = nil
        try super.tearDownWithError()
    }

    // Api test
    func testApiGetSats() {
        let expectation = self.expectation(description: "testApiGetSats")
        
        // given
        let dbn = ""
        var schoolRes: School?
        
        // when
        sutApi.apiGetSats(dbn: dbn) { school in
            // then
            schoolRes = school
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(schoolRes, "school is nil")
    }
    
    
    
    /*func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }*/
}
