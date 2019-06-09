//
//  LeagueViewController.swift
//  happybets
//
//  Created by Xavier Graham on 5/26/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit
import Firebase

class LeagueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref: DatabaseReference = Database.database().reference()
    var leagueList = [LeagueModel]()
    var user: UserModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getUser()
        loadAllLeagues()
    }
    
    // MARK: - Table View DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectLeague", for: indexPath) as? LeagueCell
        
        let league = leagueList[indexPath.row]
        
        cell!.nameLabel.text = league.name
        cell!.countLabel.text = "\(league.members.count)"
        cell!.icon.image = UIImage(named: league.imageName)
        
        return cell!
    }

    
    // MARK: - Navigation

    //Present so that CreateLeagueViewController may unwind here
    @IBAction func unwind(segue:UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if let destVC = segue.destination as?
    }
    
    func addLeague(league: LeagueModel) {
        league.storeLeague()
        leagueList.append(league)
        tableView.reloadData()
    }
    
    func loadAllLeagues() {
        //Should get all of the League data from Firebase into leagueList
        let leaguesRef = self.ref.child("leagues")
        
        leaguesRef.observeSingleEvent(of: .value) { (snapshot) in
            
            if let leaguesData = snapshot.value as? [String:[String:Any]] {
                
                for (key, value) in leaguesData {
                    self.leagueList.append(LeagueModel(name: value["name"] as! String, uid: key, code: value["code"] as! Int, imageName: value["image"] as! String))
                }
            }
    
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
