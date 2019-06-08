//
//  CreateLeagueViewController.swift
//  happybets
//
//  Created by William Hickman on 6/3/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class CreateLeagueViewController: UIViewController, UITextFieldDelegate {

    var name: String?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    // MARK: - TextField Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name = textField.text
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let button = sender as? UIBarButtonItem {
            if button.title == "Save" && checkDone() {
                //Creates league when saved and when all fields are entered
                let destVC = segue.destination as! LeagueViewController
                destVC.user!.createLeague(name: name!)
                //Updates League Overview
                destVC.addLeague(league: destVC.user!.leagues[name!]!)
            }
        }
    }
    
    //Checks whether league should be created or not (all fields have been entered in data)
    func checkDone() -> Bool {
        if name != nil {
            return true
        }
        return false
    }

}
