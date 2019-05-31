//
//  SignUpViewController.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    var emailFromLogin: String!
    
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var newPassConfirm: UITextField!
    
    @IBAction func attemptRegistration(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newEmail.text = emailFromLogin
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
