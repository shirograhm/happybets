///Users/gaberoeloffs/Desktop/happybets/happybets/happybets.xcodeproj
//  happytests.swift
//  happytests
//
//  Created by Xavier Graham on 5/17/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import XCTest
import Firebase

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
}

// MARK: League model tests
extension happytests {
    func testCreateLeague() {
        let userModel = UserModel(email: "hi@gmail.com", uid: "W8CI3S30CZ9LJQ1831POA3")
        
        XCTAssert(userModel.email == "hi@gmail.com")
        XCTAssert(userModel.uid == "W8CI3S30CZ9LJQ1831POA3")
        
        /// THIS ERRORS!
        /*
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
        */
    }
}

// MARK: Bet model tests
extension happytests {
    func testCreateBet() {
        let bet = BetModel(gameID: 7, homer: true, pointAMT: 80, uid: "W8CI3S30CZ9LJQ1831POA3", win: "in progress")
        
        XCTAssert(bet.gameID == 7)
        XCTAssert(bet.homer)
        XCTAssert(bet.pointAmount == 80)
        XCTAssert(bet.uid == "W8CI3S30CZ9LJQ1831POA3")
        XCTAssert(bet.win == "in progress")
    }
}
