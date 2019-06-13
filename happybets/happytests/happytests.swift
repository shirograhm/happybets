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
        
        // Configure Firebase app for testing
        FirebaseApp.configure()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // De-configure Firebase app for testing
        FirebaseApp.app()?.delete(firebaseDeleteCallback)
    }
    
    func firebaseDeleteCallback(success: Bool) {
        // Placeholder
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
        let testLeague = LeagueModel(name: "test", uid:"1234", code:1, imageName:"iconA")
        
        XCTAssert(testLeague.name == "test")
        XCTAssert(testLeague.uid == "1234")
        XCTAssert(testLeague.code == 1)
        XCTAssert(testLeague.imageName == "iconA")
        XCTAssertTrue(testLeague.members.isEmpty)
        XCTAssertTrue(testLeague.bets.isEmpty)
        
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
    
    func testPopulateBets() {
        //assume the league is already in firebase
        var testLeague = LeagueModel(name: "Beast-Sicko Moders", uid: "-LhHE7uKA_kwTwq4EJds", code: 1561, imageName: "iconD.png")
        
        testLeague.populateBets(userId: "Q7G15m8HYlZj4YqYoFnDjmsf5402", completion: {(Bool) -> Void in
            XCTAssertFalse(testLeague.bets.isEmpty)
            XCTAssert(testLeague.bets[0].gameID == 1)
            XCTAssert(testLeague.bets[0].homer == false)
            XCTAssert(testLeague.bets[0].pointAmount == 83)
            XCTAssert(testLeague.bets[0].win == "in progress")
        })
        
        betsRef.child("tempUserID").removeValue()
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
    
    func testStoreBet() {
        BetModel.storeBet(pts: 18, uID: "tempUserID", gameID: 2, homer: true, leagueID: "-LhHE7uKA_kwTwq4EJds")
        let betsRef = Database.database().reference().child("leagues").child("-LhHE7uKA_kwTwq4EJds").child("bets")
        
        betsRef.child("tempUserID").observe(.value) { (snapshot) in
            if let data = snapshot.value as? [String : Any] {
                XCTAssert(18 == data["pointAMT"] as! Int)
                XCTAssert(2 == data["gameID"] as! Int)
                XCTAssert(true == data["homer"] as! Bool)
                XCTAssert("in progress" == data["win"] as! String)
            }
        }
        
        betsRef.child("tempUserID").removeValue()
    }
}
