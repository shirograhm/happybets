//
//  GameModel.swift
//  happybets
//
//  Created by Xavier Graham on 6/8/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation
import Firebase

public class GameModel {
    var home: String!
    var gameID: Int!
    var away: String!
    
    init(gameID: Int, home: String, away: String) {
        self.home = home
        self.away = away
        self.gameID = gameID
    }
    
}
