//
//  LeagueViewController.swift
//  happybets
//
//  Created by Xavier Graham on 5/26/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class LeagueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var leagueList = [LeagueModel]()
    var user: UserModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadAllLeagues()
    }
    
    // MARK: - Table View DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leagueList.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectLeague", for: indexPath) as? LeagueCell
        
        //Configure custom cell
        
        return cell!
    }

    
    // MARK: - Navigation

    //Present so that CreateLeagueViewController may unwind here
    @IBAction func unwind(segue:UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass through selected League here (for join League)
    }
    
    func addLeague(league: LeagueModel) {
        league.storeLeague()
        leagueList.append(league)
        tableView.reloadData()
    }
    
    func loadAllLeagues() {
        //Should get all of the League data from Firebase into leagueList
    }

}
