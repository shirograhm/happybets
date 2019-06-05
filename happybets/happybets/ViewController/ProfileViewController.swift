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

class ProfileViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
        loadUserData()
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
