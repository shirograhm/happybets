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
        GameModel(t1: "Golden State Warriors", t2: "Toronto Raptors"),
        GameModel(t1: "Minnesota Timberwolves", t2: "Seattle Supersonics"),
        GameModel(t1: "Los Angeles Clippers", t2: "Houston Rockets"),
        GameModel(t1: "Philadelphia 76ers", t2: "New York Knicks"),
        GameModel(t1: "Denver Nuggets", t2: "San Antonio Spurs"),
        GameModel(t1: "Brooklyn Nets", t2: "Sacramento Kings")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell
        
        cell.team1.text = gamesToBetOn[indexPath.row].team1
        cell.team2.text = gamesToBetOn[indexPath.row].team2

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            if id == "toPlaceBetView" {
                let dest = segue.destination as! PlaceBetViewController
                
                dest.gameChosen = gamesToBetOn[tableView.indexPathForSelectedRow!.row]
            }
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
