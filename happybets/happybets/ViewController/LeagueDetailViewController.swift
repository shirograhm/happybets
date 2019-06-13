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
    @IBOutlet weak var addBetButton: UIButton!
    
    var members = [UserModel : Int]()
    var sortedMembers = [(key: UserModel, value: Int)]()
    var betTableData = [BetModel]()
    var leagueTitle : String?
    var leagueId : String?
    var ref: DatabaseReference = Database.database().reference()
    var selectedLeague : LeagueModel?
    var gamesData : [GameModel] = [
        GameModel(gameID: 0, home: "Golden State Warriors", away: "Toronto Raptors"),
        GameModel(gameID: 1, home: "Minnesota Timberwolves", away: "Seattle Supersonics"),
        GameModel(gameID: 2, home: "Los Angeles Clippers", away: "Houston Rockets"),
        GameModel(gameID: 3, home: "Philadelphia 76ers", away: "New York Knicks"),
        GameModel(gameID: 4, home: "Denver Nuggets", away: "San Antonio Spurs"),
        GameModel(gameID: 5, home: "Brooklyn Nets", away: "Sacramento Kings")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerTableView.delegate = self
        betTableView.delegate = self
        playerTableView.dataSource = self
        betTableView.dataSource = self
        leagueTitle = selectedLeague?.name
        leagueTitleLabel.text = leagueTitle
        leagueIcon.image = UIImage(named: selectedLeague?.imageName ?? "iconD")
        leagueId = selectedLeague?.uid
        selectedLeague?.populateMembers(completion: reloadLeaderboard)
        selectedLeague?.populateBets(userId: Auth.auth().currentUser!.uid, completion: reloadBets)
        // Do any additional setup after loading the view.
        
        members = selectedLeague!.members
        sortedMembers = sortMembers(members: members)
        betTableData = selectedLeague!.bets
        betTableView.rowHeight = 80
        // get data from firebase and fill tables
    }
    
    func sortMembers(members: [UserModel : Int]) -> [(key: UserModel, value: Int)]{
        var sortedMembers = [(key: UserModel, value: Int)]()
        for (key, value) in members {
            sortedMembers.append((key, value))
        }
        sortedMembers = sortedMembers.sorted(by: sortHelper)
        return sortedMembers
    }
    
    func sortHelper(user1: (key: UserModel,value: Int), user2: (key: UserModel, value: Int)) -> Bool{
        return (user1.value > user2.value)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func addBetPressed(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView ==  playerTableView {
            let numberOfRow = sortedMembers.count
            return numberOfRow
        }
        else if tableView == betTableView {
            let numberOfRow = betTableData.count
            return numberOfRow
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == playerTableView {
            let player = sortedMembers[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
            //fill cell with data
            cell.playerNameLabel.text = player.key.email
            cell.standingLabel.text = String(indexPath.row + 1)
            cell.pointLabel.text = String(player.value)
            return cell
        }
        else if tableView ==  betTableView {
            let bet = betTableData[indexPath.row]
            let game = gamesData[bet.gameID]
            var teamPicked = ""
            if bet.homer {
                teamPicked = game.home
            }
            else {
                teamPicked = game.away
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "betCell", for: indexPath) as! BetCell
            //fill cell with data
            cell.teamPickedLabel.text = teamPicked
            cell.pointWageredLabel.text = String(bet.pointAmount)
            if bet.win == "win" {
                cell.backgroundColor = .red
            }
            else if bet.win == "lost" {
                cell.backgroundColor = .green
            }
            else if bet.win == "in progress" {
                cell.backgroundColor = .yellow
            }
            else {
                cell.backgroundColor = .white
            }
            return cell
        }
        return UITableViewCell()
    }
    
//    func loadAllGames(completion: @escaping () -> Void) {
//        //Should get all of the League data from Firebase into leagueList
//        let gamesRef = self.ref.child("games")
//        gamesRef.observeSingleEvent(of: .value) { (snapshot) in
//            if let gamesData = snapshot.value as? [[String:Any]] {
//                for singleGameData in gamesData {
//                    self.gamesData.append(GameModel(gameID: singleGameData["gameID"] as! Int, home: singleGameData["home"] as! String, away: singleGameData["away"] as! String))
//                }
//                completion()
//            }
//        }
//    }
    
    func hasUser(user1: (key: UserModel,value: Int)) {
        return
    }
    
    func reloadLeaderboard(success: Bool) {
        if success {
            members = selectedLeague!.members
            if (members[UserModel(email: "", uid: Auth.auth().currentUser!.uid)] != nil) {
                addBetButton.setTitle("Add Bet", for: .normal)
                addBetButton.addTarget(self, action: #selector(addBet), for: .touchUpInside)
            }
            else {
                addBetButton.setTitle("Not in league", for: .normal)
                addBetButton.addTarget(self, action: #selector(showNotInLeague), for: .touchUpInside)
            }
            sortedMembers = sortMembers(members: members)
            playerTableView.reloadData()
        }
        else {
            print("error loading data")
        }
    }
    
    @objc func addBet(sender: UIButton!) {
        performSegue(withIdentifier: "toPlaceBetView", sender: nil)
    }
    
    @objc func showNotInLeague(sender: UIButton!) {
        let badAddBetAlert = UIAlertController(title: "Can't Add Bet", message: "You must join the league to add bets", preferredStyle: .alert)
        badAddBetAlert.addAction(UIAlertAction(title: "Got it", style: .cancel))
        self.present(badAddBetAlert, animated: true, completion: nil)
    }
    
    func reloadBets(success: Bool) {
        if success {
            betTableData = selectedLeague!.bets
            betTableView.reloadData()
        }
        else {
            print("error loading data")
        }
    }
    
    @IBAction func unwindToDetail(segue: UIStoryboardSegue) {
        // Reload data once the bet was placed
        selectedLeague!.populateBets(userId: Auth.auth().currentUser!.uid, completion: reloadBets)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaceBetView" {
            let dest = segue.destination as! PlaceBetViewController
            
            dest.leagueID = leagueId
        }
    }
}
