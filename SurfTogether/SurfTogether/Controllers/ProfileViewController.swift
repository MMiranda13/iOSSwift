//
//  ProfileViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 02/09/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var quiverView: UIView!
    @IBOutlet weak var forecastView: UIView!
    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var quiverButton: UIButton!
    @IBOutlet weak var forecastButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    
    //let userEmail = Auth.auth().currentUser?.email
    
    let db = Firestore.firestore()
    
    //    var users: [User] = [
    //        User(username: "JosePeneda", email: "josepeneda@dea.pt", level: "Beginner", Friends: 0, quiver: nil)
    //    ]
    var user = User(username: "JosePeneda", email: "afea", level: "ola", friends: 0, quiver: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title = "Surf Together 🏄"
        navigationItem.hidesBackButton = true
        topView.layer.cornerRadius = 12
        quiverView.layer.cornerRadius = 12
        forecastView.layer.cornerRadius = 12
        calendarView.layer.cornerRadius = 12
        quiverButton.layer.cornerRadius = 12
        forecastButton.layer.cornerRadius = 12
        calendarButton.layer.cornerRadius = 12
        
        loadUser()
    }
    
    //  func addUser(){
    //db.collection("users").addDocument(data: <#T##[String : Any]#>, completion: <#T##((Error?) -> Void)?#>)
    //  }
    
    func loadUser() {
        
        usernameLabel.text = user.username
        levelLabel.text = user.level
        friendsLabel.text = String(user.friends)
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
}
