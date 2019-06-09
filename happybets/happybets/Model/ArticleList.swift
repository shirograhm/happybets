//
//  ArticleList.swift
//  happybets
//
//  Created by user155240 on 6/8/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation

struct ArticleList : Codable {
    let articles : Result
    
    struct Result : Codable{
        let list : [Article]
        
        enum CodingKeys : String, CodingKey {
            case list = "results"
        }
    }
    enum CodingKeys : String, CodingKey {
        case articles = "articles"
    }
}
