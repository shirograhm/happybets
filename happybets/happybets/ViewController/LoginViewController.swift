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
    var emailFromSignUp: String!
    //Needs to be init somewhere her
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passText: UITextField!
    
    @IBAction func attemptLogin(_ sender: UIButton) {
        print(userText.text! + " " + passText.text!)
        AuthenticatorModel.login(withEmail: userText.text ?? "", password: passText.text ?? "", getUser)
    }
    
    public func getUser(_ result: AuthDataResult?) {
        if let _ = result?.user.uid {
            // Successfully logged in
            performSegue(withIdentifier: "toLeagueView", sender: self)
        } else {
            let badLoginAlert = UIAlertController(title: "Failed Login", message: "Invalid email and/or password.", preferredStyle: .alert)
            badLoginAlert.addAction(UIAlertAction(title: "Got it", style: .cancel))
            self.present(badLoginAlert, animated: true, completion: nil)
        }
    }
    
    @IBAction func newUserRequest(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUp", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userText.delegate = self
        passText.delegate = self
        userText.text = emailFromSignUp
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userText.resignFirstResponder()
        passText.resignFirstResponder()
        return true
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination

        if segue.identifier == "toLeagueView" {
            // Do stuff to get to league view
            let tabbar = dest as! SuperTabViewController
        }
        
        if segue.identifier == "toSignUp" {
            let signup = dest as! SignUpViewController
            signup.emailFromLogin = userText.text ?? ""
        }
    }
}
