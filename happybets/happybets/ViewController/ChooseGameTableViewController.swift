//
//  ChooseGameTableViewController.swift
//  happybets
//
//  Created by Xavier Graham on 6/8/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class ChooseGameTableViewController: UITableViewController {
    
    var gamesToBetOn = [
        GameModel(gameID: 0, home: "Golden State Warriors", away: "Toronto Raptors"),
        GameModel(gameID: 1, home: "Minnesota Timberwolves", away: "Seattle Supersonics"),
        GameModel(gameID: 2, home: "Los Angeles Clippers", away: "Houston Rockets"),
        GameModel(gameID: 3, home: "Philadelphia 76ers", away: "New York Knicks"),
        GameModel(gameID: 4, home: "Denver Nuggets", away: "San Antonio Spurs"),
        GameModel(gameID: 5, home: "Brooklyn Nets", away: "Sacramento Kings")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gamesToBetOn.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameToChooseCell", for: indexPath) as! GameTableViewCell
        
        cell.homeTeamLabel.text = gamesToBetOn[indexPath.row].home
        cell.awayTeamLabel.text = gamesToBetOn[indexPath.row].away
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "toPlaceBetView" {
                let dest = segue.destination as! PlaceBetViewController
                
                dest.gameChosen = gamesToBetOn[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
}
