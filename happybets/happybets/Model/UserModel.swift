//
//  UserModel.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//
import Foundation
import Firebase

class UserModel: Hashable {
    
    // user singleton
    static var sharedUserModel = UserModel()
    
    var ref: DatabaseReference = Database.database().reference()
    var email:String!
    var password:String!
    var uid:String!
    var leagues = [String : LeagueModel]()

    
    // private initializer
    private init(){}
    
    init(email:String, uid:String){
        self.email = email
        self.uid = uid
    }

    // returns with success and the code of the league that was created
    func createLeague(name:String, imageName:String, completion: @escaping (_ code: Bool, _ leagueCode:Int?) -> Void) {
        let code = generateCode()
        
        let data:[String:Any] = ["name":name, "image":imageName, "code":code, "users":[getUserInfoDictionary()]]
        
        self.ref.child("leagues").childByAutoId().setValue(data){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                
                print("Data could not be saved: \(error).")
                completion(false, nil)
            } else {
                
                let leagueDict = [ref.key!:["name":name, "uid":ref.key!, "code":code, "image":imageName]] as [String : Any]
                
                self.ref.child("users").child(Auth.auth().currentUser!.uid).child("leagues").updateChildValues(leagueDict, withCompletionBlock: { (userErr, userRef) in
                if let userErr = userErr {
                    print("Data could not be saved: \(userErr).")
                    completion(false, nil)
                } else {
                    print("Data saved successfully!")
                    completion(true, code)
                }
            })
           
            }
        }
        
        
    }
    // join a league with a code -> success or failure
    func joinLeague(code:Int, completion: @escaping (_ success: Bool) -> Void){
        print("checking for code \(code)")
        let leaguesRef = self.ref.child("leagues")
        
        leaguesRef.observeSingleEvent(of: .value) { (snapshot) in
            print(snapshot.value!)
            let leaguesData = snapshot.value as! [String:[String:Any]]
            
            var codeFound = false
            
            var foundValue:[String:Any]?
            var foundKey:String?
            
            for (key, value) in leaguesData{
                if (value["code"] as! Int) == code{
                    codeFound = true
                    foundValue = value
                    foundKey = key
                }
            }
            
            if codeFound == true{
                // the code was found, add the user to the league
                var usersData = foundValue!["users"] as! [[String:Any]]
                
                //add the user to the league's user list
                usersData.append(self.getUserInfoDictionary())
                
                let data:[String:Any] = ["name":foundValue!["name"] as! String, "code":foundValue!["code"]!, "users":usersData]
                
                self.ref.child("leagues").child(foundKey!).setValue(data){
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                        completion(false)
                    } else {
                        
                        let name = foundValue!["name"] as! String
                        let foundCode = foundValue!["code"] as! String
                        
                        let leagueDict = [foundKey!:["name":name, "uid":foundKey!, "code":foundCode]] as [String : Any]
 self.ref.child("users").child(Auth.auth().currentUser!.uid).child("leagues").updateChildValues(leagueDict, withCompletionBlock: { (userErr, userRef) in
                            if let userErr = userErr {
                                print("Data could not be saved: \(userErr).")
                                completion(false)
                            } else {
                                print("Data saved successfully!")
                                completion(true)
                            }
                        })
                    }
                }
                
            // if the code was not found
            }else{
                completion(false)
            }
        }
    }
    
    // returns the leagues that a user is in
    // the leagues returned don't have the users loaded,
    // this requires another DB call
    func getLeagues(completion: @escaping (_ leagues: [LeagueModel]) -> Void){
        
        let leaguesRef = self.ref.child("users").child(Auth.auth().currentUser!.uid).child("leagues")
        
        leaguesRef.observeSingleEvent(of: .value) { (snapshot) in
            let leagues = snapshot.value! as! [String:[String:Any]]
            
            var leagueModels = [LeagueModel]()
            for (key, value) in leagues{
                let leagueModel =  LeagueModel(name: value["name"] as! String, uid: key, code: value["code"] as! Int, imageName: value["image"] as! String)
                leagueModels.append(leagueModel)
            }
            
            completion(leagueModels)
            
        }
    }
    
    func getUserInfoDictionary() -> [String:Any]{
        return ["email":Auth.auth().currentUser!.email!, "uid":Auth.auth().currentUser!.uid, "points":100]
    }
    
    func generateCode() -> Int{
        var result = ""
        repeat {
            // Create a string with a random number 0...9999
            result = String(format:"%04d", arc4random_uniform(10000) )
        } while result.count < 4
        return Int(result)!
    }
    
    // MARK: - Hashable functions
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    
}
