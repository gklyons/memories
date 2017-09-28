//
//  EventTableViewController.swift
//  Memories
//
//  Created by Garrett Lyons on 9/25/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    // MARK - Properties
    
    var occasion: Occasion?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return occasion?.memories?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell")!
        
        guard let memories = occasion?.memories else { return UITableViewCell() }
        if memories.count == 0 {
            return UITableViewCell()
        } else {
            let memoriesArray = Array(memories)
            guard let memory = memoriesArray[indexPath.row] as? Memory else { return UITableViewCell() }
            
            cell.textLabel?.text = memory.title
            cell.detailTextLabel?.text = "\(memory.timestamp)"
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //            let event = EventController.shared.event[indexPath.row]
            //            EventController.deleteEvent(event: event)
            //            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEventDetail" {
            let occasion = self.occasion
            let eventMemoryVC = segue.destination as? EventMemoryViewController
            eventMemoryVC?.occasion = occasion
        } else {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let occasion = self.occasion,
                let memories = occasion.memories else { return }
            let memoryArray = Array(memories)
            guard let memory = memoryArray[indexPath.row] as? Memory else { return }
            let memoryVC = segue.destination as? EventMemoryViewController
            memoryVC?.occasion = occasion
            memoryVC?.memory = memory
        }
    }
}
