//
//  RegisterViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 01/09/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var surflevelTextfield: UITextField!
    
    let db = Firestore.firestore()
    var user = User(username: "", email: "", level: "", friends: 0, quiver: nil)
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text, let username = usernameTextfield.text, let level = surflevelTextfield.text {
            
            let userToAdd = User(username: username, email: email, level: level, friends: 0, quiver: nil)
            
            self.addDocument(userToAdd)
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "registerToProfile", sender: self)
                }
            }
        }
    }
    
    func addDocument(_ userReceived: User) {
        db.collection("users").addDocument(data: ["username": userReceived.username, "email": userReceived.email, "level": userReceived.level]) { (error) in
            if let e = error {
                print ("There was an issue saving data to Firestore, \(e)")
            } else {
                print("Successfully saved data.")
            }
        }
    }
    
}
