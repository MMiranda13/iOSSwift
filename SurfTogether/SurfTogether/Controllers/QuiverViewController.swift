//
//  QuiverViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 08/09/2022.
//

import UIKit
import FirebaseFirestore

class QuiverViewController: UIViewController {
    
    @IBOutlet weak var tableViewBoards: UITableView!
    @IBOutlet weak var tableViewWetsuits: UITableView!
    
    let db = Firestore.firestore()
    var quivers = [Quiver]()
    var wetsuits = [Wetsuit]()
    var listeners = [ListenerRegistration]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // method to tell the table view how to create new cells.
        tableViewBoards.register(UITableViewCell.self, forCellReuseIdentifier: "ReusableCell")
        tableViewBoards.dataSource = self
        tableViewBoards.layer.cornerRadius = 8
        
        // method to tell the table view how to create new cells.
        tableViewWetsuits.register(UITableViewCell.self, forCellReuseIdentifier: "WetsuitCell")
        tableViewWetsuits.dataSource = self
        tableViewWetsuits.layer.cornerRadius = 8
        
        // registration of the new nib cell created so the table view starts to use
        tableViewBoards.register(UINib(nibName: "QuiverCell", bundle: nil), forCellReuseIdentifier: "QuiverReusableCell")
        tableViewWetsuits.register(UINib(nibName:"WetsuitCell", bundle: nil), forCellReuseIdentifier: "WetsuitReusableCell")
        
        setupBindings()
    }
    
    func setupBindings() {
        guard listeners.isEmpty else { return }
        
        // adds listener to a document that creates a snapshot and everytime its called and everytime the doc changes.
        listeners.append(
            db.collection("users").document(Docid.userID).collection("quiver").addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    let received = self.queryParsing(query: querySnapshot, type: Quiver.self)
                    //   organizing the array values per date
                    self.quivers = received.sorted { elem1, elemt2 in
                        elem1.dateField < elemt2.dateField
                    }
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.reloadTables()
                    }
                }
            }
        )
        
        listeners.append(
            db.collection("users").document(Docid.userID).collection("wetsuit").addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                
                if let error = error {
                    print("Error getting wetsuit documents: \(error)")
                } else {
                    print("\(self.wetsuits)")
                    
                    self.wetsuits = self.queryParsing(query: querySnapshot, type: Wetsuit.self)
                    DispatchQueue.main.async { [weak self] in
                        self?.reloadTables()
                    }
                }
            }
        )
        
    }
    
    func queryParsing<Object: Decodable>(query: QuerySnapshot?, type: Object.Type) ->[Object] {
        
        var received = [Object]()
        if let documents = query?.documents {
            
            // for loop to search in determinate collection or document
            for document in documents {
                
                if let jsonData = try? JSONSerialization.data(withJSONObject: document.data(),
                                                              options: []),
                   let parsedObject = try? JSONDecoder().decode(Object.self, from: jsonData) {
                    received.append(parsedObject)
                    
                }
            }
            
            
            print("Query was sucessful")
            
            
        } else {
            debugPrint("nothing to show")
        }
        
        return received
    }
    
    func reloadTables() {
        tableViewBoards.reloadData()
        tableViewWetsuits.reloadData()
    }
}

extension QuiverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView == tableViewBoards ? quivers.count : wetsuits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewBoards {
            guard indexPath.row < quivers.count,
                  let cell = tableView.dequeueReusableCell(withIdentifier: "QuiverReusableCell", for: indexPath) as? QuiverCell else { return UITableViewCell() }
            
            let quiver = quivers[indexPath.row]
            
            cell.modelLabel.text = quiver.model
            cell.sizeLabel.text = quiver.size
            cell.brandLabel.text = quiver.brand
            
            return cell
        } else {
            guard indexPath.row < wetsuits.count, let cell = tableView.dequeueReusableCell(withIdentifier: "WetsuitReusableCell", for: indexPath) as? WetsuitCell else { return UITableViewCell() }
            
            let wetsuit = wetsuits[indexPath.row]
            
            cell.thicknessLabel.text = wetsuit.thickness
            cell.brandModelLabel.text = wetsuit.brandModel
            
            return cell
        }
    }
}

//ADICIONAR DELEGATE PARA ANIMAR SELEÇÃO DAS ROWS
