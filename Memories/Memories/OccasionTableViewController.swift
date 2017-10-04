//
//  OccasionTableViewController.swift
//  Memories
//
//  Created by Garrett Lyons on 9/22/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit
import CoreData

class OccasionTableViewController: UITableViewController, UITextFieldDelegate, NSFetchedResultsControllerDelegate {
    
    let fetchResultController: NSFetchedResultsController<Occasion> = {
        let request: NSFetchRequest<Occasion> = Occasion.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    // MARK - Actions
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        self.presentAddOccasionAlert()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OccasionController.shared.occasions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "occasionCell", for: indexPath)
        
        let occasion = OccasionController.shared.occasions[indexPath.row]
        cell.textLabel?.text = occasion.title
        
        guard let events = occasion.memories else { return cell }
        
        if events.count == 1 {
            cell.detailTextLabel?.text = "1 Item"
        } else {
            let eventCount = events.count
            cell.detailTextLabel?.text = "\(eventCount) Items"
        }
        
        return cell
    }
    
    //    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return "Occasions"
    //    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let occasion = OccasionController.shared.occasions[indexPath.row]
            OccasionController.shared.deleteOccasion(occasion: occasion)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Alert
    
    func presentAddOccasionAlert() {
        
        var occasionTextField: UITextField?
        let alertController = UIAlertController(title: "Create an event. (example 'Christmas')", message: nil, preferredStyle: .alert)
        alertController.addTextField{ (textField) in
            textField.placeholder = "Enter title here."
            textField.autocapitalizationType = .words
            occasionTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let title = occasionTextField?.text, title != "" else { return }
            OccasionController.shared.createOccasion(title: title)
            self.tableView.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEvents" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let occasion = OccasionController.shared.occasions[indexPath.row]
            let eventVC = segue.destination as? EventTableViewController
            eventVC?.occasion = occasion
        }
    }
}
