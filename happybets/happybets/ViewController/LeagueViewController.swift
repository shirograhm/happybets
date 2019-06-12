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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserModel.sharedUserModel.getLeagues(completion: { (leagues) -> Void in
            DispatchQueue.main.async {
                self.leagueList = leagues
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Table View DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "yeet", for: indexPath) as? LeagueCell
        
        let league = leagueList[indexPath.row]
        
        league.populateMembers(completion: { (success) -> Void in
            if (success) {
                cell!.countLabel.text = "Members: \(league.members.count)"
            }
        })
        
        cell!.nameLabel.text = league.name
        cell!.icon.image = UIImage(named: league.imageName)
        
        return cell!
    }

    
    // MARK: - Navigation

    //Present so that CreateLeagueViewController may unwind here
    @IBAction func unwind(segue:UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? LeagueDetailViewController {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            destVC.selectedLeague = leagueList[(selectedIndexPath?.row)!]
        }
    }
    
    func addLeague(league: LeagueModel) {
        league.storeLeague()
        leagueList.append(league)
        tableView.reloadData()
    }
}
