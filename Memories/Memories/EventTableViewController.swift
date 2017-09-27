//
//  EventTableViewController.swift
//  Memories
//
//  Created by Garrett Lyons on 9/25/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
<<<<<<< HEAD

=======
    
    // MARK - Properties
    
    var occasion = Occasion()
>>>>>>> developGarrett
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
<<<<<<< HEAD

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return occasion?.events?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)

//        if let event = occasion?.events?[indexPath.row] as? Event {
//            cell.textLabel?.text = event.title
//        }

        return cell
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
//            guard let event = self.event else { return }
//            let eventMemoryVC = segue.destination as? EventMemoryViewController
//            eventMemoryVC?.event = event
        }
    }

    // MARK - Properties
    
    var occasion: Occasion?
    
=======
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OccasionController.shared.occasion.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        
        guard let memories = occasion.memories else { return UITableViewCell() }
        if memories.count == 0 {
            return UITableViewCell()
        } else {
            let memoriesArray = Array(memories)
            guard let memory = memoriesArray[indexPath.row] as? Memory else { return UITableViewCell() }
            
            cell.textLabel?.text = memory.title
            cell.detailTextLabel?.text = "\(String(describing: memory.timestamp))"
            
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
//            guard let occasion = self.occasion
//            let eventMemoryVC = segue.destination as? EventMemoryViewController
//            eventMemoryVC?.occasion = occasion
            
        }
    }
>>>>>>> developGarrett
}




<<<<<<< HEAD







=======
>>>>>>> developGarrett
