//
//  LoginViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 01/09/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginEmailTextfield: UITextField!
    @IBOutlet weak var loginPasswordTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = loginEmailTextfield.text, let password = loginPasswordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                    
                } else {
                    self.getIdDoc()
                    self.performSegue(withIdentifier:"loginToProfile" , sender: self)
                }
            }
        }
    }
    func getIdDoc () {
        db.collection("users").whereField("email", isEqualTo: Auth.auth().currentUser?.email).getDocuments(completion: { ( querySnapshot, Error) in
            if let Error = Error {
                print("Error getting documents: \(Error)")
            } else {
                for document in querySnapshot!.documents {
                    let docID = document.documentID
                    Docid.userID = docID
                    print("\(docID)")
                }
            }
        })
    }
    
}
