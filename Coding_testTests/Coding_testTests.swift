//
//  Coding_testTests.swift
//  Coding_testTests
//
//  Created by Kanghos on 2024/01/25.
//

import XCTest
@testable import Coding_test

final class Coding_testTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
      let request = RealtimeReq(accessKey: "1234", currentcies: ["JPY"])
      let target = Target.realtime(request: request)
      let endPoint = EndPoint(target: target)
      let urlRequest = endPoint.toRequest()

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
