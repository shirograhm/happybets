//
//  LeagueModel.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation
import Firebase

class LeagueModel {
    
    var name: String
    var imageName: String
    var uid: String
    var code: Int
    var members = [UserModel : Int]()
    var ref: DatabaseReference = Database.database().reference()

    init(name: String, uid:String, code:Int, imageName:String) {
        self.name = name
        self.uid = uid
        self.code = code
        self.imageName = imageName
    }
    
    // pulls the mambers of a league from the database
    func populateMembers(completion: @escaping (_ success:Bool) -> Void){
        let usersRef = self.ref.child("leagues").child(self.uid).child("users")
        
        usersRef.observeSingleEvent(of: .value) { (snapshot) in
            let userData = snapshot.value! as! [[String:Any]]
            
            for singleUserData in userData{
                let userModel = UserModel(email: singleUserData["email"] as! String, uid: singleUserData["uid"] as! String)
                self.members.updateValue(singleUserData["points"] as! Int, forKey: userModel)
            }
            
            completion(true)
            
        }
    }

    func storeLeague() {
        
    }
    
    func createBet() {
        
    }
    
}
