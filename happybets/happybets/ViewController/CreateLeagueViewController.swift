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
    var imageName: String?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var buttons = [buttonA, buttonB, buttonC, buttonD]
        for button in buttons {
            button!.showsTouchWhenHighlighted = true
        }
    }
    
    // MARK: - TextField Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name = textField.text
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func pressedA(_ sender: Any) {
        imageName = "iconA.png"
    }
    @IBAction func pressedB(_ sender: Any) {
        imageName = "iconB.png"
    }
    @IBAction func pressedC(_ sender: Any) {
        imageName = "iconC.png"
    }
    @IBAction func pressedD(_ sender: Any) {
        imageName = "iconD.png"
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let button = sender as? UIBarButtonItem {
            if button.title == "Save" && checkDone() {
                //Creates league when saved and when all fields are entered
                let destVC = segue.destination as! LeagueViewController
//                destVC.user!.createLeague(name: name!, imageName)
                //Updates League Overview
                destVC.addLeague(league: destVC.user!.leagues[name!]!)
            }
        }
    }
    
    //Checks whether league should be created or not (all fields have been entered in data)
    func checkDone() -> Bool {
        if name != nil && imageName != nil {
            return true
        }
        return false
    }

}
