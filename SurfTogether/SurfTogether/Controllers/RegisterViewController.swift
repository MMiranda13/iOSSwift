//
//  RegisterViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 01/09/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
//import iOSDropDown

class RegisterViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
   
    
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    @IBOutlet weak var surfLevelTextfield: UITextField!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    let surflevel = ["Beginner","Intermediate","Advanced","Pro"]
    var pickerView = UIPickerView()
    
    let db = Firestore.firestore()
    var user = User(username: "", email: "", level: "", friends: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        pickerView.delegate = self
        pickerView.dataSource = self
        surfLevelTextfield.isSelected = true
        surfLevelTextfield.inputView = pickerView
        
    }
    
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
    
        if !surflevel.contains(surfLevelTextfield.text!){
            resetUI()
        }
        
        if let email = emailTextfield.text, let password = passwordTextfield.text, let username = usernameTextfield.text, let level = surfLevelTextfield.text {
            
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
        surfLevelTextfield.text = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return surflevel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
          return surflevel[row]
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {
            surfLevelTextfield.text = surflevel[row]
            surfLevelTextfield.resignFirstResponder()
        }
    
}
