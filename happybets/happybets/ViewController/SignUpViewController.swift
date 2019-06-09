//
//  SignUpViewController.swift
//  happybets
//
//  Created by Xavier Graham on 5/23/19.
//  Copyright © 2019 Happy Bets LLC. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    var emailFromLogin: String!
    
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var newPass: UITextField!
    @IBOutlet weak var newPassConfirm: UITextField!
    
    @IBAction func attemptRegistration(_ sender: UIButton) {
        if (newPass.text != newPassConfirm.text) {
            let badSignUpAlert = UIAlertController(title: "Failed Sign Up", message: "Passwords don't match", preferredStyle: .alert)
            badSignUpAlert.addAction(UIAlertAction(title: "Got it", style: .cancel))
            self.present(badSignUpAlert, animated: true, completion: nil)
        }
//        else if (!(newPass.text?.contains("1234567890!@#$%^&*()") ?? false) || newPass.text?.count ?? 0 < 8) {
//            let badSignUpAlert = UIAlertController(title: "Failed Sign Up", message: "Passwords must be 8 characters long and contain a number and at least one of the following symbols: !@#$%^&*()", preferredStyle: .alert)
//            badSignUpAlert.addAction(UIAlertAction(title: "Got it", style: .cancel))
//            self.present(badSignUpAlert, animated: true, completion: nil)
//        }
        else {
            AuthenticatorModel.createUser(email: newEmail.text ?? "", password: newPass.text ?? "", registerUser)
        }
    }
    
    public func registerUser(_ error: Error?) {
        if  (error != nil) {
            let badSignUpAlert = UIAlertController(title: "Failed Sign Up", message: error.debugDescription, preferredStyle: .alert)
            badSignUpAlert.addAction(UIAlertAction(title: "Got it", style: .cancel))
            self.present(badSignUpAlert, animated: true, completion: nil)
            
        } else {
            // Successfully registered
            let goodSignUpAlert = UIAlertController(title: "Successful Sign Up", message: "Click Login", preferredStyle: .alert)
            goodSignUpAlert.addAction(UIAlertAction(title: "Got it", style: .cancel))
            self.present(goodSignUpAlert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newEmail.delegate = self
        newPass.delegate = self
        newPassConfirm.delegate = self
        newEmail.text = emailFromLogin
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newEmail.resignFirstResponder()
        newPass.resignFirstResponder()
        newPassConfirm.resignFirstResponder()
        return true
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        
        if segue.identifier == "toLogin" {
            let login = dest as! LoginViewController
            login.emailFromSignUp = newEmail.text ?? ""
        }
    }
}
