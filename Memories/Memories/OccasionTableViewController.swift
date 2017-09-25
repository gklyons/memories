//
//  OccasionTableViewController.swift
//  Memories
//
//  Created by Garrett Lyons on 9/22/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class OccasionTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    // MARK - Outlets
    
    @IBOutlet weak var occasionTextField: UITextField!
    
    // MARK - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let occasionTitle = occasionTextField.text, !occasionTitle.isEmpty else { return }
        OccasionController.shared.createOccasion(title: occasionTitle)
        occasionTextField.text = ""
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OccasionController.shared.occasion.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "occasionCell", for: indexPath)
        
        let occasion = OccasionController.shared.occasion[indexPath.row]
        cell.detailTextLabel?.text = occasion.title
        
        if occasion.events?.count == 1 {
            cell.detailTextLabel?.text = "1 Item"
        } else {
            let eventCount = occasion.events?.count ?? 0
            cell.detailTextLabel?.text = "\(eventCount) Items"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Occasions"
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            _ = OccasionController.shared.occasion[indexPath.row]
            OccasionController.shared.deleteOccasion(title: title!)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventList",
            let indexPath = tableView.indexPathForSelectedRow {
            let occasion = OccasionController.shared.occasion[indexPath.row]
            let eventVC = segue.destination as? EventTableViewController
            eventVC?.occasion = occasion
        }
    }
}




