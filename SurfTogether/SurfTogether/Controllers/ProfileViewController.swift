//
//  ProfileViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 02/09/2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
//import SwiftUI

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var quiverView: UIView!
    @IBOutlet weak var forecastView: UIView!
    @IBOutlet weak var calendarView: UIView!
    
    @IBOutlet weak var quiverButton: UIButton!
    @IBOutlet weak var forecastButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var gearButton: UIButton!
    
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var alphaLayer: UIVisualEffectView?
    
    let db = Firestore.firestore()
    
        var users: [User] = [
            User(username: "", email: "", level: "", friends: 0)
        ]
    
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
        
        showLoading(true)
        
        loadUser()
    }
    
    func showLoading(_ show: Bool) {
        if show {
            alphaLayer?.isHidden = false
            activity.startAnimating()
        } else {
            activity.stopAnimating()
            
        }
        
        let animationDuration = show ? 0.0 : 0.66666
        
        UIView.animate(withDuration: animationDuration, animations: { [weak self] in
            self?.alphaLayer?.alpha = show ? 1.0 : 0.0
        }, completion: { [weak self] _ in
            self?.alphaLayer?.isHidden = !show
        })
        
    }
    
    func loadUser() {
        guard let email = Auth.auth().currentUser?.email else {
            debugPrint("No email on Auth")
            return
        }
        
        db.collection("users").whereField("email", isEqualTo: email).getDocuments(completion: { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
            } else if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    
                    if let usernameLab = document.get("username") as? String,
                       let levelLab = document.get("level") as? String {
                        
                        self.usernameLabel.text = "Username: \(usernameLab)"
                        self.levelLabel.text = "Surf Level: \(levelLab)"
                        self.friendsLabel.text = "Friends: 0"
                        print("Query was Sucessfull")
                    }
                }
            }
            
            self.showLoading(false)
        })
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
    
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
    }
    
}


