    //
//  PeopleTabViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/19/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

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
            PersonController.shared.deletePerson(person: person)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
    
