//
//  NewGroupViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/20/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit
import CoreData

class NewGroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SelectPersonTableViewCellDelegate {
    
    // MARK: - Properties
    
    var chosenPeople: [Person] = []
    var group: Group?
    var people = PersonController.shared.people
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var groupNameTextField: UITextField!
    
    // MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let groupName = groupNameTextField.text else { return }
        
        if group == nil {
            GroupController.shared.createGroup(name: groupName, people: chosenPeople)
        } else {
            group?.name = groupName
            let setOfPeople = NSSet(array: chosenPeople)
            group?.people = setOfPeople
            guard let group = group else { return }
            GroupController.shared.updateGroup(group: group)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if group != nil {
            groupNameTextField.text = group?.name
        }
        
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
    }
    
    // MARK: Table View Data Source Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as? SelectPersonTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        let person = people[indexPath.row]
        
        if group != nil {
            guard let group = group,
                let people = group.people else { return UITableViewCell() }
            
            let peopleArray = Array(people) as! [Person]
        
            if peopleArray.contains(person) {
                cell.nameLabel.text = person.name
                cell.isSelectedButton.setBackgroundImage(#imageLiteral(resourceName: "complete"), for: .normal)
                person.isSelected = true
                chosenPeople.append(person)
            } else {
                cell.nameLabel.text = person.name
            }
        } else {
            cell.nameLabel.text = person.name
        }

        return cell
    }
    
    // MARK: SelectServiceTableViewCellDelegate funcion
    
    func personWasSelected(cell: SelectPersonTableViewCell) {
        
        guard let indexPath = peopleTableView.indexPath(for: cell) else { return }
        
//        var differenceInIndexPaths: Int?
//        if indexPath.row == people.count && people.count != chosenPeople.count {
//            differenceInIndexPaths = people.count - chosenPeople.count - 1
//        } else {
//            differenceInIndexPaths = people.count - chosenPeople.count
//        }
//
//        var person: Person?
//
//        if cell.isSelectedButton.currentBackgroundImage == #imageLiteral(resourceName: "complete") {
//            guard let differenceInIndexPaths = differenceInIndexPaths else { return }
//            person = chosenPeople[indexPath.row - differenceInIndexPaths]
//        } else {
//            for person in people {
//                person.isSelected = false
//            }
//
//            person = people[indexPath.row]
//        }
        
        let person = people[indexPath.row]
        let firstIndexPath = IndexPath(row: 0, section: 0)
        let willBeSelected = !person.isSelected
        
        if willBeSelected == true {
            person.isSelected = willBeSelected
            chosenPeople.insert(person, at: 0)
            people.remove(at: indexPath.row)
            people.insert(person, at: 0)
            peopleTableView.moveRow(at: indexPath, to: firstIndexPath)
        } else {
            person.isSelected = willBeSelected
            chosenPeople.remove(at: indexPath.row)
        }
        
        cell.person = person
    }
}



























