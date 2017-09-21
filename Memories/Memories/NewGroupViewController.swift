//
//  NewGroupViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/20/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SelectPersonTableViewCellDelegate {
    
    // MARK: - Properties
    
    var chosenPeople: [Person] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var groupNameTextField: UITextField!
    
    // MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let groupName = groupNameTextField.text else { return }
        
//        for person in PersonController.shared.people {
//            if person.isSelected == true {
//                chosenPeople.append(person)
//                person.isSelected = !person.isSelected
//            }
//        }
        
        GroupController.shared.createGroup(name: groupName, people: chosenPeople)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
    }
    
    // MARK: Table View Data Source Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PersonController.shared.people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as? SelectPersonTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        let person = PersonController.shared.people[indexPath.row]
        
        cell.nameLabel.text = person.name
        
        return cell
    }
    
    // MARK: SelectServiceTableViewCellDelegate funcion
    
    func personWasSelected(cell: SelectPersonTableViewCell) {
        
        guard let indexPath = peopleTableView.indexPath(for: cell) else { return }
        
        let person = PersonController.shared.people[indexPath.row]
        let willBeSelected = !person.isSelected
        
        if willBeSelected == true {
            person.isSelected = willBeSelected
            chosenPeople.append(person)
        } else {
            person.isSelected = willBeSelected
        }
        
        cell.person = person
    }
}



























