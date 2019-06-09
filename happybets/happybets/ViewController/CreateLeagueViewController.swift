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
    var user: UserModel?
    var save = false
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var selectedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TextField Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name = textField.text
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func pressedA(_ sender: Any) {
        imageName = "iconA.png"
        selectedImage.image = UIImage(named: imageName!)
    }
    @IBAction func pressedB(_ sender: Any) {
        imageName = "iconB.png"
        selectedImage.image = UIImage(named: imageName!)
    }
    @IBAction func pressedC(_ sender: Any) {
        imageName = "iconC.png"
        selectedImage.image = UIImage(named: imageName!)
    }
    @IBAction func pressedD(_ sender: Any) {
        imageName = "iconD.png"
        selectedImage.image = UIImage(named: imageName!)
    }
    @IBAction func createPressed(_ sender: Any) {
        if checkDone() {
            save = true
            performSegue(withIdentifier: "back", sender: nil)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if save {
            //Creates league when saved and when all fields are entered
            let destVC = segue.destination as! LeagueViewController
            destVC.user!.createLeague(name: name!, imageName: imageName!, completion: { (success, leagueCode) -> Void in
                if success {
                    destVC.user?.joinLeague(code: leagueCode!, completion: { (success) -> Void in
                        
                    })
                }
            })
            destVC.user?.getLeagues(completion: { (leagues) -> Void in
                for league in leagues {
                    destVC.user?.leagues.updateValue(league, forKey: league.uid)
                }
            })
            //Updates League Overview
            destVC.addLeague(league: destVC.user!.leagues[name!]!)
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
