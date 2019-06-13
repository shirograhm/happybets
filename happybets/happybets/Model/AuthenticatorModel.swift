//
//  AuthenticaterModel.swift
//  happybets
//
//  Created by Conor Schofield on 5/16/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation
import Firebase

public class AuthenticatorModel {
    
    public static func createUser(email: String, password: String, _ callback: ((Error?) -> ())? = nil) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            let ref: DatabaseReference = Database.database().reference()

            if let e = error {
                callback?(e)
                return
            }
            
            ref.child("users").child(Auth.auth().currentUser!.uid).setValue(AuthenticatorModel.getUserInfoDictionary()) {
                    (error:Error?, ref:DatabaseReference) in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                        callback?(error)
                    } else {
                        callback?(nil)
                    }
                }
        }
    }
    
    public static func getUserInfoDictionary() -> [String:Any]{
        return ["email":Auth.auth().currentUser!.email!, "uid":Auth.auth().currentUser!.uid, "totalPoints":100]
    }

    public static func login(withEmail email: String, password: String, _ callback: @escaping ((AuthDataResult?) -> ())) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let e = error {
                print(e)
                callback(nil)
                return
            }
            callback(user)
        }
    }
    
    public static func signOut() -> Bool {
        do{
            try Auth.auth().signOut()
            return true
        }catch{
            return false
        }
    }
    
    public static func reloadUser(_ callback: ((Error?) -> ())? = nil) {
        Auth.auth().currentUser?.reload(completion: { (error) in
            callback?(error)
        })
    }
}
