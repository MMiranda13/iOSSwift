//
//  LoginViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 01/09/2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginEmailTextfield: UITextField!
    @IBOutlet weak var loginPasswordTextfield: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = loginEmailTextfield.text, let password = loginPasswordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    
                } else {
                    
                    self.performSegue(withIdentifier:"loginToProfile" , sender: self)
                }
            }
        }
    }
}
