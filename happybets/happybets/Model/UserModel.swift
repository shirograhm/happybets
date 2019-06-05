//
//  UserModel.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation
import Firebase

class UserModel: Hashable, Equatable {
    
    var leagues = [String : LeagueModel]()
    var totalPoints: Int
    var id: String
    
    
    init(totalPoints: Int) {
        self.totalPoints = totalPoints
        self.id = Auth.auth().currentUser!.uid
    }
    
    func storeUser() {
        
    }
    
    func loginUser() {
        
    }
    
    func createLeague(name: String) {
        let league = LeagueModel(name: name, user: self)
        leagues.updateValue(league, forKey: league.name)
    }
    
    func joinLeague() {
        
    }
    
    func addAdmin(league: LeagueModel, user: UserModel) {
        if league.admins.contains(self) {
            league.admins.append(user)
        }
    }
    
    func requestArticles() {
        
    }
    
    func viewSingleArticle() {
        
    }
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
