//
//  UserModel.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation

class UserModel {
    
    static var userModel: UserModel!
    
    var ref: DatabaseReference!
    var email:String!
    var password:String!
    
    func createLeague(name:String, completion: @escaping (_ success: Bool) -> Void) {
        ref = Database.database().reference()
        
        self.ref.child("leagues").childByAutoId().setValue(["name", name]){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                completion(false)
            } else {
                print("Data saved successfully!")
                completion(true)
            }
        }
    }
    
    func joinLeague(code:Int) {
        
    }
    func storeUser() {
        
    }
    
    func loginUser() {
        
    }
    
    func createLeague() {
        
    }
    
    func joinLeague() {
        
    }
    
    func requestArticles() {
        
    }
    
    func viewSingleArticle() {
        
    }
    
}
