//
//  LeagueModel.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation

class LeagueModel {
    
    var name: String
    var admins = [UserModel]()
    var members = [UserModel : Int]()
    var bets = [BetModel]()
    
    init(name: String, user: UserModel) {
        //The user who created the League will be the first member and admin
        self.name = name
        self.members.updateValue(100, forKey: user)
        self.admins.append(user)
    }
    
    func storeLeague() {
        
    }
    
    func createBet() {
        
    }
    
}
