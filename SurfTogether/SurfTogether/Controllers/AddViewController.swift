//
//  AddViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 13/09/2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import Firebase

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var sizeTextfield: UITextField!
    @IBOutlet weak var brandTextfield: UITextField!
    @IBOutlet weak var modelTextfield: UITextField!
    
    @IBOutlet weak var wetsuitTextfield: UITextField!
    
    
    let db = Firestore.firestore()
    var quiver = Quiver(size: "0.0", brand: "", model: "", dateField: Date().timeIntervalSince1970, wetsuit: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addBoardPressed(_ sender: UIButton) {
        if let size = sizeTextfield.text, let brand = brandTextfield.text, let model = modelTextfield.text {
            
            db.collection("users").document(Docid.userID).collection("quiver")
                .addDocument(data:
                                ["size": size, "brand": brand, "model": model, "dateField": Date().timeIntervalSince1970],
                             completion: { [weak self] (error) in
                if let error = error {
                    print("There was an issue saving data to firestore, \(error)")
                } else {
                    print("Successfully saved data.")
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss(animated: true)
                }
            })
        }
    }
    


}




