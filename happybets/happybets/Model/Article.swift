//
//  Article.swift
//  happybets
//
//  Created by user155240 on 6/8/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation

struct Article : Codable {
    let title : String
    let body : String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case body = "body"
    }
}
