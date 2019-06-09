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
    var gamesData : [GameModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueTitle = selectedLeague?.name
        leagueTitleLabel.text = leagueTitle
        leagueIcon.image = UIImage(named: selectedLeague?.imageName ?? "iconD")
        leagueId = selectedLeague?.uid
        // Do any additional setup after loading the view.
        playerTableView.delegate = self
        betTableView.delegate = self
        playerTableView.dataSource = self
        betTableView.dataSource = self
        
        ref = Database.database().reference()
        loadAllPlayers(completion: reloadLeaderboard)
        playerTableData.sort(by: compareUserModel)
        loadPlayersBets(completion: reloadBets)
        loadAllGames {
            print("success")
        }
        // get data from firebase and fill tables
    }
    
    func compareUserModel(user1: UserModel, user2: UserModel) -> Bool {
        return user1.points > user2.points
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    @IBAction func addBetPressed(_ sender: Any) {
        
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
            cell.setLabels(standing: String(indexPath.row), playerName: player.email, points: String(player.points))
        case betTableView:
            let bet = betTableData[indexPath.row]
            let game = gamesData[bet.gameID]
            var teamPicked = ""
            if bet.home {
                teamPicked = game.home
            }
            else {
                teamPicked = game.away
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "betCell", for: indexPath) as! BetCell
            //fill cell with data
            cell.setLabels(teamPicked: teamPicked, pointsWagered: bet.pointAMT)
            if bet.win == "win" {
                cell.backgroundColor = .red
            }
            else if bet.win == "lost"{
                cell.backgroundColor = .green
            }
            else if bet.win == "in progess"{
                cell.backgroundColor = .yellow
            }
            else {
                cell.backgroundColor = .white
            }
        default:
            print("error")
        }
        return cell
    }
    
    func loadAllPlayers(completion: @escaping () -> Void) {
        //Should get all of the League data from Firebase into leagueList
        let playersRef = self.ref.child("leagues").child(leagueId ?? "").child("users")
        playersRef.observe(.childAdded, with: { (snapshot) in
            if let playersData = snapshot.value as? [Int:[String:Any]] {
                for (key, value) in playersData {
                    self.playerTableData.append(UserModel(email: value["email"] as! String, uid: value["uid"] as! String, points: value["points"] as! Int))
                }
                completion()
            }
        })
    }
    
    func loadAllGames(completion: @escaping () -> Void) {
        //Should get all of the League data from Firebase into leagueList
        let gamesRef = self.ref.child("games")
        gamesRef.observeSingleEvent(of: .value) { (snapshot) in
            if let gamesData = snapshot.value as? [Int:[String:Any]] {
                for (key, value) in gamesData {
                    self.leagueList.append(GameModel(gameID: value["gameID"] as! String, home: value["home"] as! String, away: value["away"]))
                }
                completion()
            }
        }
    }
    
    func loadPlayersBets(completion: @escaping () -> Void) {
        //Should get all of the League data from Firebase into leagueList
        let betsRef = self.ref.child("leagues").child(leagueId ?? "").child("bets")
        betsRef.observe(.childAdded, with: { (snapshot) in
            if let betsData = snapshot.value as? [Int:[String:Any]] {
                for (key, value) in betsData {
                    if (value["uid"] as! String == Auth.auth().currentUser!.uid) {
                        self.betTableData.append(BetModel(gameID: value["gameID"] as! Int, homer: value["homer"] as! Bool, pointAMT: value["pointAMT"] as! Int, uid: value["uid"] as! String, win: value["win"] as! String))
                    }
                }
                completion()
            }
        })
    }
    
    func reloadLeaderboard() {
        playerTableView.reloadData()
    }
    
    func reloadBets() {
        betTableView.reloadData()
    }
    
}
