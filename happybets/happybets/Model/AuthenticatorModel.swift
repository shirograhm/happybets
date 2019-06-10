//
//  AuthenticaterModel.swift
//  happybets
//
//  Created by Conor Schofield on 5/16/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import Foundation
import Firebase

class AuthenticatorModel {
    
    public static func createUser(email: String, password: String, _ callback: ((Error?) -> ())? = nil) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let e = error {
                callback?(e)
                return
            }
            callback?(nil)
        }
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
