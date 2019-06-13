//
//  NewsTests.swift
//  happytests
//
//  Created by user155240 on 6/10/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import XCTest

class NewsTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreateUrl(){
        let news = NewsModel()
        
        let url = news.createUrl()
        
        XCTAssert(url != "")
        XCTAssert(url.count > 1)
    }
    
    func testRetrieveArticles(){
        let news = NewsModel()
        
        news.retrieveArticles(closure : testRetrieveArticlesHelper)
    }
    
    func testRetrieveArticlesHelper(articles : [Article]){
        XCTAssert(articles.count != 0)
        XCTAssert(articles[0].title.count > 0)
        XCTAssert(articles[0].body.count > 0)
    }
}
