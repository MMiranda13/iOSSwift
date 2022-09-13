//
//  QuiverViewController.swift
//  SurfTogether
//
//  Created by Dinis Henriques on 08/09/2022.
//

import UIKit

class QuiverViewController: UIViewController {
    
    @IBOutlet weak var tableViewBoards: UITableView!
    @IBOutlet weak var tableViewWetsuits: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewBoards.register(UITableViewCell.self, forCellReuseIdentifier: "ReusableCell")
        tableViewBoards.dataSource = self
        tableViewBoards.layer.cornerRadius = 8
        
        tableViewWetsuits.register(UITableViewCell.self, forCellReuseIdentifier: "WetsuitCell")
        tableViewWetsuits.dataSource = self
        tableViewWetsuits.layer.cornerRadius = 8
    }
}

extension QuiverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewBoards {
            return 8
        }
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewBoards {
            let cell = tableViewBoards.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
            cell.textLabel?.text = "Surfboard"
            return cell
        } else {
            let cell = tableViewWetsuits.dequeueReusableCell(withIdentifier: "WetsuitCell", for: indexPath)
            cell.textLabel?.text = "Wetsuit"
            return cell
        }
    }
}

//ADICIONAR DELEGATE PARA ANIMAR SELEÇÃO DAS ROWS




