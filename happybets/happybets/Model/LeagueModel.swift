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
    var bets =  [BetModel]()
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
    
    func populateBets(completion: @escaping (_ success:Bool) -> Void) {
        //Should get all of the League data from Firebase into leagueList
        let betsRef = self.ref.child("leagues").child(self.uid).child("bets")
        betsRef.observeSingleEvent(of: .value) { (snapshot) in
            if let betsData = snapshot.value as? [String:[String:Any]] {
                for (key, value) in betsData {
                    if (key == Auth.auth().currentUser!.uid) {
                        self.bets.append(BetModel(gameID: value["gameID"] as! Int, homer: value["homer"] as! Bool, pointAMT: value["pointAMT"] as! Int, uid: key, win: value["win"] as! String))
                    }
                }
                completion(true)
            }
        }
    }

    func storeLeague() {
        
    }
    
    func createBet() {
        
    }
    
}
