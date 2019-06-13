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

extension happytests{
    
    func testUserCreateLeague(){
        
        AuthenticatorModel.login(withEmail: "g@gmail.com", password: "password") { (results) in
            UserModel.sharedUserModel.createLeague(name: "My League", imageName: "iconA.png") { (success, code) in
                XCTAssert(success == true)
            }
        }

    }
    
    func testGetLeagues(){
        AuthenticatorModel.login(withEmail: "g@gmail.com", password: "password") { (results) in
            UserModel.sharedUserModel.createLeague(name: "My League", imageName: "iconA.png") { (success, code) in
                UserModel.sharedUserModel.getLeagues(completion: { (models) in
                    XCTAssert(models.count > 0)
                })
            }
        }
    }
    
    func testCreateUser(){
        let userModel = UserModel(email: "hello@gmail.com", uid: "W8CI3S30CZ9LJQ1832POA3")
        
        XCTAssert(userModel.email == "hello@gmail.com")
        XCTAssert(userModel.uid == "W8CI3S30CZ9LJQ1832POA3")
    }
    
    func testGenerateCode(){
        let userModel = UserModel(email: "hello@gmail.com", uid: "W8CI3S30CZ9LJQ1832POA3")
        
        // make sure code generated is four digits
        XCTAssert(userModel.generateCode() < 10000)
    }
    
    func testGetUserInfoDictionary(){
        let expected = ["email":"hello@gmail.com", "uid":"W8CI3S30CZ9LJQ1832POA3", "points":100] as [String : Any]
        
        let userModel = UserModel(email: "hello@gmail.com", uid: "W8CI3S30CZ9LJQ1832POA3")
        
        XCTAssert(expected["email"] as! String == userModel.email!)
        XCTAssert(expected["uid"] as? String == userModel.uid)
    }
    
    func testJoinLeagueSuccess(){
        AuthenticatorModel.login(withEmail: "g@gmail.com", password: "password") { (results) in
            UserModel.sharedUserModel.createLeague(name: "My League 1", imageName: "iconA.png") { (success, code) in
                UserModel.sharedUserModel.joinLeague(code: code!, completion: { (success) in
                    XCTAssert(success == true)
                })
            }
        }
    }
    
    func testJoinLeague(){
        UserModel.sharedUserModel.joinLeague(code: 1234) { (success) in
            XCTAssert(success == false)
        }
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
