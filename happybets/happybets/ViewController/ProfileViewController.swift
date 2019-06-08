//
//  ProfileViewController.swift
//  happybets
//
//  Created by Xavier Graham on 5/26/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
        loadUserData()
        
        UserModel.sharedUserModel.getLeagues { (leagues) in
            //
            for league in leagues{
                print(league.name)
                league.populateMembers(completion: { (success) in
                    for member in league.members{
                        print(member.email)
                    }
                })
            }
        }


        
    }
    
    func loadUserData() {
        if let userID = Auth.auth().currentUser?.uid {
            ref.child("users").child(userID).observe(.value, with: { (snapshot) in
                print(snapshot)
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
