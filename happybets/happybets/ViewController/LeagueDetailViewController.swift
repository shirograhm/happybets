//
//  LeagueDetailViewController.swift
//  happybets
//
//  Created by Conor Schofield on 6/4/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class LeagueDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var playerTableView: UITableView!
    @IBOutlet weak var betTableView: UITableView!
    @IBOutlet weak var leagueTitleLabel: UILabel!
    @IBOutlet weak var leagueIcon: UIImageView!
    
    var playerTableData : [UserModel] = []
    var betTableData : [BetModel] = []
    var leagueTitle : String?
    var leagueId : String?
    var ref : DatabaseReference!
    var databaseHandle : DatabaseHandle?
    var selectedLeague : LeagueModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueTitle = selectedLeague?.name
        leagueTitleLabel.text = leagueTitle
        leagueIcon.image = UIImage(named: selectedLeague?.imageName ?? "iconD")
        // Do any additional setup after loading the view.
        playerTableView.delegate = self
        betTableView.delegate = self
        playerTableView.dataSource = self
        betTableView.dataSource = self
        
        ref = Database.database().reference()
        
        databaseHandle = ref?.child(leagueId ?? "").child("users").observe(.childAdded, with: { (snapshot) in
            // try to convert data to UserModel
            //self.playerTableData.append()
        })
        
        databaseHandle = ref?.child("users").child(Auth.auth().currentUser!.uid).child(leagueId ?? "").child("bets").observe(.childAdded, with: { (snapshot) in
            //listen for changes to bets
        })
        // get data from firebase and fill tables
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRow = 1
        switch tableView {
        case playerTableView:
            numberOfRow = playerTableData.count
        case betTableView:
            numberOfRow = betTableData.count
        default:
            print("error")
        }
        return numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        switch tableView {
        case playerTableView:
            let player = playerTableData[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
            //fill cell with data
            cell.setLabels(standing: String(indexPath.row), playerName: player.email, points: "0")
        case betTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "betCell", for: indexPath)
            
        default:
            print("error")
        }
        
        return cell
    }
    
}
