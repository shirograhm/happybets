///Users/gaberoeloffs/Desktop/happybets/happybets/happybets.xcodeproj
//  happytests.swift
//  happytests
//
//  Created by Xavier Graham on 5/17/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import XCTest
import Firebase
import UserModel

class happytests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEasyNumbers() {
        XCTAssert(1 + 1 == 2)
        XCTAssertFalse(1 + 3 < -10)
        XCTAssert("hello there".contains("hello"))
    }
    
    func testAdminLogins() {
        // Some code to test our authentication here
    }
    
    func testCreateLeague(){
        
        let userModel = UserModel()
        
        let originalImages = loadImages()
        // Create an expectation
        let expectation = self.expectation(description: "Scaling")
        var scaledImages: [UIImage]?
        scaler.scale(originalImages) {
            scaledImages = $0
            // Fullfil the expectation to let the test runner
            // know that it's OK to proceed
            expectation.fulfill()
        }
        // Wait for the expectation to be fullfilled, or time out
        // after 5 seconds. This is where the test runner will pause.
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(scaledImages?.count, originalImages.count)
    

    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Some time-pertinent function tests
            let x = 8.0
            let y = x - 3.5
            let z = y + 3 * x
            print(String(z) + " is a cool number!")
        }
    }
    
    
}
