//
//  RegisterViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 01/09/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import iOSDropDown

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var surflevelTextfield: UITextField!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    @IBOutlet weak var dropDown: DropDown!
    
    let db = Firestore.firestore()
    var user = User(username: "", email: "", level: "", friends: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.optionArray = ["Beginner","Intermediate","Advanced","Pro"]
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text, let username = usernameTextfield.text, let level = dropDown.text {
            
            loadingView.startAnimating()
            
            let userToAdd = User(username: username, email: email, level: level, friends: 0)
            
            self.createUser(userToAdd, password: password, completion: { [weak self] result in
                
                guard let self = self else {
                    return
                }
                
                
                if let authResult = result {
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
    
    func addDocument(_ userReceived: User, completion: @escaping (Error?) -> Void ) -> String {
        let document = db.collection("users").addDocument(data: ["username": userReceived.username, "email": userReceived.email, "level": userReceived.level], completion: { (error) in
            
            completion(error)
        })
        let docID = document.documentID
        print(docID)
        Docid.userID = docID
        return document.documentID
    }
    
    func createUser(_ userToAdd: User, password: String, completion: @escaping (AuthDataResult?) -> Void) {
        
        Auth.auth().createUser(withEmail: userToAdd.email, password: password) { authResult, error in
            if let error = error {
                print(error)
                completion(nil)
            } else {
                
                completion(authResult)
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
