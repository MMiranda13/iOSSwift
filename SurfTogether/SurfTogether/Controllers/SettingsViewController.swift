//
//  SettingsViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 26/09/2022.
//

import UIKit
import FirebaseFirestore

class SettingsViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var surfLevelTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    let surflevel = ["Beginner","Intermediate","Advanced","Pro"]
    var pickerView = UIPickerView()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        surfLevelTextField.inputView = pickerView
    }
    @IBAction func updateButton(_ sender: UIButton) {
        

        if usernameTextField.text!.isEmpty && surfLevelTextField.text!.isEmpty {
            usernameTextField.placeholder  = "Insert Username Please"
            surfLevelTextField.placeholder = "Insert Surf Level Please"
            
        } else if usernameTextField.text!.isEmpty  {
            if !surflevel.contains(surfLevelTextField.text!){
                resetUI()
            } else {
            db.collection("users").document(Docid.userID).updateData([
                "level": surfLevelTextField.text
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                    
                } else {
                    print("Document successfully updated")
                    self.performSegue(withIdentifier: "goToProfile", sender: self)
                }
            }
            }
        } else if surfLevelTextField.text!.isEmpty {
        db.collection("users").document(Docid.userID).updateData([
            "username": usernameTextField.text
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
                
            } else {
                print("Document successfully updated")
                self.performSegue(withIdentifier: "goToProfile", sender: self)
            }
        }
        } else {
            
        db.collection("users").document(Docid.userID).updateData([
            "level": surfLevelTextField.text,
            "username": usernameTextField.text
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
                
            } else {
                print("Document successfully updated")
                self.performSegue(withIdentifier: "goToProfile", sender: self)
            }
        }
        }
    }
    func resetUI () {
        usernameTextField.text = ""
        surfLevelTextField.text = ""
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
            surfLevelTextField.text = surflevel[row]
            surfLevelTextField.resignFirstResponder()
        }

}
