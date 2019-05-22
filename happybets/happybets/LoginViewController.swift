//
//  LoginViewController.swift
//  happybets
//
//  Created by Xavier Graham on 5/9/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    

    
    @IBAction func attemptLogin(_ sender: UIButton) {
        print(userText.text! + " " + passText.text!)
        AuthenticatorModel.login(withEmail: userText.text ?? "", password: passText.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userText.delegate = self
        passText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userText.resignFirstResponder()
        passText.resignFirstResponder()
        return true
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
