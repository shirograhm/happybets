//
//  LeagueJoinViewController.swift
//  happybets
//
//  Created by William Hickman on 6/9/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class LeagueJoinViewController: UIViewController, UITextFieldDelegate {

    var code: String?
    var found = false
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet var image: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        statusLabel.text = ""
    }
    
    // MARK: - TextField Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        code = textField.text
        textField.resignFirstResponder()
        
        LeagueModel.loadAllLeagues(completion: { (leagues) -> Void in
            for league in leagues {
                if league.code == Int(self.code!) {
                    self.found = true
                    self.image.image = UIImage(named: "yes.png")
                    self.statusLabel.text = "League Available"
                    self.statusLabel.textColor = UIColor(hue: 0.3417, saturation: 1, brightness: 0.59, alpha: 1.0)
                    self.nameLabel.text = "Name: \(league.name)"
                    self.iconImage.image = UIImage(named: league.imageName)
                }
            }
            if !self.found {
                self.image.image = UIImage(named: "no.png")
                self.statusLabel.text = "League Not Found"
                self.statusLabel.textColor = .red
                self.nameLabel.text = "Name: "
                self.iconImage.image = nil
            }
        })
        
        return true
    }
    
    @IBAction func joinPressed(_ sender: Any) {
        if found {
            UserModel.sharedUserModel.joinLeague(code: Int(code!)!, completion: { (success) -> Void in
                if !success {
                    print("Unable to join league")
                }
            })
        }
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
