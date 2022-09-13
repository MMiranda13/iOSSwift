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
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    let db = Firestore.firestore()
    var user = User(username: "", email: "", level: "", friends: 0, quiver: nil)
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text, let username = usernameTextfield.text, let level = surflevelTextfield.text {
            
            loadingView.startAnimating()
            
            let userToAdd = User(username: username, email: email, level: level, friends: 0, quiver: nil)
            
            self.createUser(userToAdd, password: password, completion: { [weak self] success in
                
                guard let self = self else {
                    return
                }
                
                
                if success {
                    //User Created
                    self.addDocument(userToAdd, completion: { [weak self] error in
                        guard let self = self else {
                            return
                        }
                        self.loadingView.stopAnimating()
                        if let error = error { //Erro adding doc
                            print ("There was an issue saving data to Firestore, \(error)")
                        } else {
                            print("Successfully saved data.")
                            self.performSegue(withIdentifier: "registerToProfile", sender: self)
                            
                        }
                    })
                } else {
                    //ERROR ON AUTH
                    DispatchQueue.main.async { [weak self] in
                        self?.loadingView.stopAnimating()
                        self?.resetUI()
                    }
                    
                }
            })
        }
    }
    
    func addDocument(_ userReceived: User, completion: @escaping (Error?) -> Void ) {
        db.collection("users").addDocument(data: ["username": userReceived.username, "email": userReceived.email, "level": userReceived.level], completion: { (error) in
            
            completion(error)
        })
    }
    
    func createUser(_ userToAdd: User, password: String, completion: @escaping (Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: userToAdd.email, password: password) { authResult, error in
            if let error = error {
                print(error)
                completion(false)
            } else {
                
                completion(true)
            }
        }
    }
    
    func resetUI () {
        usernameTextfield.text = ""
        emailTextfield.text = ""
        passwordTextfield.text = ""
        surflevelTextfield.text = ""
    }
    
}
