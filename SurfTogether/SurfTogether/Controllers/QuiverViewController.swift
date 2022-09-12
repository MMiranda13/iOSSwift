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
        
        tableViewBoards.dataSource = self
       // tableViewBoards.register(UINib(nibName: QuiverCell, bundle: nil), forCellReuseIdentifier: "ReusableCell")
        tableViewBoards.layer.cornerRadius = 8
        tableViewWetsuits.layer.cornerRadius = 8
    }
    
    
    
}

extension QuiverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        cell.textLabel?.text = "Surfboard"
        return cell
    }
    
    
}


