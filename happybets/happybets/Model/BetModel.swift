//
//  BetModel.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation
import Firebase

public class BetModel {
    
    var gameID: Int!
    var homer: Bool!
    var pointAmount: Int!
    var uid: String!
    var win: String!
    
    public init(gameID: Int, homer: Bool, pointAMT: Int, uid: String, win: String) {
        self.gameID = gameID
        self.homer = homer
        self.pointAmount = pointAMT
        self.uid = uid
        self.win = win
    }
    
    public static func storeBet(pts: Int, uID: String, gameID: Int, homer: Bool, leagueID: String) {
        let ref: DatabaseReference! = Database.database().reference()
        
        ref.child("leagues").child(leagueID).child("bets").child(uID).child("gameID").setValue(gameID)
        ref.child("leagues").child(leagueID).child("bets").child(uID).child("homer").setValue(homer)
        ref.child("leagues").child(leagueID).child("bets").child(uID).child("pointAMT").setValue(pts)
        ref.child("leagues").child(leagueID).child("bets").child(uID).child("win").setValue("in progress")
        
    }
}
