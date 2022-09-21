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
    var listener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewBoards.register(UITableViewCell.self, forCellReuseIdentifier: "ReusableCell")
        tableViewBoards.dataSource = self
        tableViewBoards.layer.cornerRadius = 8
        
        tableViewWetsuits.register(UITableViewCell.self, forCellReuseIdentifier: "WetsuitCell")
        tableViewWetsuits.dataSource = self
        tableViewWetsuits.layer.cornerRadius = 8
        
        tableViewBoards.register(UINib(nibName: "QuiverCell", bundle: nil), forCellReuseIdentifier: "QuiverReusableCell")
        
        setupBindings()
    }
    
    func setupBindings() {
        listener = db.collection("users").document(Docid.userID).collection("quiver").addSnapshotListener { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.queryParsing(querySnapshot)
            }
        }
    }
    
    func queryParsing(_ query: QuerySnapshot?) {
        wetsuits = [Wetsuit]()
        
        if let documents = query?.documents {
            var received = [Quiver]()
            for document in documents {
                
                if let jsonData = try? JSONSerialization.data(withJSONObject: document.data(),
                                                              options: []),
                   let quiver = try? JSONDecoder().decode(Quiver.self, from: jsonData) {
                    received.append(quiver)
                    
                    if let wetsuit = quiver.wetsuit {
                        wetsuits.append(wetsuit)
                    }
                }
            }
            
            quivers = received.sorted { elem1, elemt2 in
                elem1.dateField < elemt2.dateField
            }
            
            print("Query was sucessful, \n\(quivers)")
            
            DispatchQueue.main.async { [weak self] in
                self?.reloadTables()
            }
        } else {
            debugPrint("nothing to show")
        }
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
            guard indexPath.row < wetsuits.count else { return UITableViewCell() }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "WetsuitCell", for: indexPath)
            
            let wetsuit = wetsuits[indexPath.row]
            
            cell.textLabel?.text = wetsuit.brand
            
            return cell
        }
    }
}

//ADICIONAR DELEGATE PARA ANIMAR SELEÇÃO DAS ROWS




