//
//  SignInVC.swift
//  GymPower
//
//  Created by Эмиль Шалаумов on 16/11/2018.
//  Copyright © 2018 Emil Shalaumov. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signInButton.layer.cornerRadius = 8
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setUsername()
        if AuthService.instance.isLoggedIn {
            performSegue(withIdentifier: "showMainVC", sender: nil)
        }
    }
    
    func setUsername() {
        if let user = Auth.auth().currentUser {
            AuthService.instance.isLoggedIn = true
            let emailComponents = user.email?.components(separatedBy: "@")
            if let username = emailComponents?[0] {
                AuthService.instance.username = username
            }
        } else {
            AuthService.instance.isLoggedIn = false
            AuthService.instance.username = nil
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func signInButtontapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(title: "Error", message: "Please enter an email and password")
            return
        }
        guard email != "", password != "" else {
            showAlert(title: "Error", message: "Please enter an email and password")
            return
        }
        
        AuthService.instance.emailLogin(email: email, password: password, completion: { (success, message) in
            if success {
                self.setUsername()
                self.performSegue(withIdentifier: "showMainVC", sender: nil)
            } else {
                self.showAlert(title: "Failure", message: message)
            }
        })
    }
    

}
