//
//  UserModel.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation

class UserModel {
    
    var leagues = [String : LeagueModel]()
    
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
    
    func requestArticles() {
        
    }
    
    func viewSingleArticle() {
        
    }
    
}
