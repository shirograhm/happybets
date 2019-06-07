//
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
    
    func testCreateLeague(){
        
        FirebaseApp.configure()
        
        UserModel.sharedUserModel.createLeague(name: "First League") { (success) in
            // maybe succeeded
        }
        XCTAssert(1 + 1 == 2)
    }

    func testEasyNumbers() {
        XCTAssert(1 + 1 == 2)
        XCTAssertFalse(1 + 3 < -10)
        XCTAssert("hello there".contains("hello"))
    }
    
    func testAdminLogins() {
        // Some code to test our authentication here
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
