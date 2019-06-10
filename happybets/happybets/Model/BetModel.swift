//
//  BetModel.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation
import Firebase

class BetModel {
    
    var gameID: Int!
    var homer: Bool!
    var pointAmount: Int!
    var uid: String!
    var win: String!
    
    init(gameID: Int, homer: Bool, pointAMT: Int, uid: String, win: String) {
        self.gameID = gameID
        self.homer = homer
        self.pointAmount = pointAMT
        self.uid = uid
        self.win = win
    }
    
    public static func storeBet(pts: Int, uID: String, gm: GameModel, tm1: Bool) {
        // TODO: Store bet into firebase
        print(pts)
        print(uID)
        print(gm)
        print(tm1)
    }
}
