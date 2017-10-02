//
//  PeopleTabViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/19/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit
import CoreData

class PeopleTabViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var peopleListTableView: UITableView!
    
    // MARK: - IBActions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peopleListTableView.delegate = self
        peopleListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        peopleListTableView.reloadData()
    }
    
    // MARK: - Table View Data Source Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell")!
        
        let person = PersonController.shared.people[indexPath.row]
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let person = PersonController.shared.people[indexPath.row]
            let alert = UIAlertController(title: "Are you sure?", message: "You are going to delete \(person.name ?? "this person").", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let okayAction = UIAlertAction(title: "Okay", style: .default) { (uiAlertAction) in
                PersonController.shared.deletePerson(person: person)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            alert.addAction(cancelAction)
            alert.addAction(okayAction)
            present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToPersonViewFromPersonCell",
            let indexPath = peopleListTableView.indexPathForSelectedRow {
            let person: Person = PersonController.shared.people[indexPath.row]
            let personVC = segue.destination as? PersonViewController
            personVC?.person = person
        }
    }
}
    

    
