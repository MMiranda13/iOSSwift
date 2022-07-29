//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription) //possivel colocar esta informação numa label ou pop-up
            
            } else {
                //Navigate to the Chat view controller
                self.performSegue(withIdentifier: "registerGoToChat", sender: self)
            }
        }
        }
        
        
        //registerGoToChat
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerGoToChat" {
            let destinationVC = segue.destination as! ChatViewController
            
        }
    }
    
}
