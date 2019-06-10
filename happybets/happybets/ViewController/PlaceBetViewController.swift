//
//  PlaceBetViewController.swift
//  happybets
//
//  Created by Xavier Graham on 6/8/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit
import Firebase

class PlaceBetViewController: UIViewController {
    
    @IBOutlet weak var lowPointBound: UILabel!
    @IBOutlet weak var highPointBound: UILabel!
    @IBOutlet weak var teamSelect: UISegmentedControl!
    @IBOutlet weak var pointSlider: UISlider!
    @IBOutlet weak var pointsDisplay: UILabel!
    @IBOutlet weak var gameDisplayTable: UITableView!
    
    var gamesToBetOn : [GameModel] = [
        GameModel(gameID: 0, home: "Golden State Warriors", away: "Toronto Raptors"),
        GameModel(gameID: 1, home: "Minnesota Timberwolves", away: "Seattle Supersonics"),
        GameModel(gameID: 2, home: "Los Angeles Clippers", away: "Houston Rockets"),
        GameModel(gameID: 3, home: "Philadelphia 76ers", away: "New York Knicks"),
        GameModel(gameID: 4, home: "Denver Nuggets", away: "San Antonio Spurs"),
        GameModel(gameID: 5, home: "Brooklyn Nets", away: "Sacramento Kings")
    ]
    
    var leagueID: String!
    
    @IBAction func sliderUpdated(_ sender: UISlider) {
        pointsDisplay.text = String(Int(sender.value))
    }
    
    @IBAction func betSubmitted(_ sender: UIButton) {
        // Ask confirmation
        let betConfirm = UIAlertController(title: "Confirm", message: "Are you sure? Press below to confirm your bet. Once you commit, you cannot go back.", preferredStyle: .alert)
        let betYes = UIAlertAction(title: "Yes", style: .destructive, handler: betWasConfirmed)
        let betNo = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        betConfirm.addAction(betNo)
        betConfirm.addAction(betYes)
        
        self.present(betConfirm, animated: true, completion: nil)
    }
    
    func betWasConfirmed(action: UIAlertAction) {
        let isHomer = (teamSelect.selectedSegmentIndex == 0)
        // Create new bet model
        BetModel.storeBet(pts: Int(pointSlider!.value), uID: Auth.auth().currentUser!.uid, gameID: gameChosen.gameID, homer: isHomer, leagueID: leagueID)
        performSegue(withIdentifier: "unwindToDetail", sender: self)
    }
    
    var gameChosen: GameModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let pointMin = 10
        let pointMax = 100
        // Smallest bet is 10 points
        lowPointBound.text = String(pointMin)
        highPointBound.text = String(pointMax)
        // Set point sliders
        pointSlider.minimumValue = Float(pointMin)
        pointSlider.maximumValue = Float(pointMax)
        
        gameDisplayTable.delegate = self
        gameDisplayTable.dataSource = self
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

extension PlaceBetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesToBetOn.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gameDisplayTable.dequeueReusableCell(withIdentifier: "gameCell") as! GameTableViewCell
        
        cell.homeTeamLabel.text = gamesToBetOn[indexPath.row].home
        cell.awayTeamLabel.text = gamesToBetOn[indexPath.row].away
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Games To Bet On"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = gamesToBetOn[indexPath.row]
        
        teamSelect.setTitle(selected.home, forSegmentAt: 0)
        teamSelect.setTitle(selected.away, forSegmentAt: 1)
        gameChosen = selected
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
