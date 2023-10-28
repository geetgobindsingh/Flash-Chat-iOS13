//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Geet Gobind Singh on 21/10/2019.
//  Copyright © 2019 Geet Gobind Singh. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        title = "Login"
    }
    

    @IBAction func loginPressed(_ sender: UIButton) {
        let email = emailTextfield.text!
        let password = passwordTextfield.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let strongSelf = self else { return }
            if let e = error {
                print("ERROR \(e.localizedDescription)")
            } else {
                strongSelf.performSegue(withIdentifier: K.loginSegue, sender: self)
            }
        }
         
    }
    
}
