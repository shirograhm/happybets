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

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var ref: DatabaseReference!
    var leagueModels = [LeagueModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
        self.emailLabel.text = Auth.auth().currentUser!.email!
        
        UserModel.sharedUserModel.getLeagues { (leagues) in
            //
            self.leagueModels = leagues
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let league = leagueModels[indexPath.row]
        
        let cell = UITableViewCell()
        cell.textLabel?.text = league.name
        cell.detailTextLabel?.text = String(league.code)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueModels.count
    }
    
    //Required for unwind
    @IBAction func unwind(segue:UIStoryboardSegue) {
        
    }
    
}
