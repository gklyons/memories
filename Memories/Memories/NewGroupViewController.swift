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
        } else {
            for person in people {
                person.isSelected = false
            }
        }
        
        peopleTableView.delegate = self
        peopleTableView.dataSource = self
    }
    
    // MARK: Table View Data Source Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if group == nil {
            return people.count
        } else {
            return group?.people?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell") as? SelectPersonTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        
        if group != nil {
            guard let group = group,
                let people = group.people else { return UITableViewCell() }
            
            let peopleArray = Array(people) as! [Person]
            
            let person = peopleArray[indexPath.row]
            cell.nameLabel?.text = person.name
            cell.isSelectedButton.setBackgroundImage(#imageLiteral(resourceName: "complete"), for: .normal)
            cell.isSelectedButton.isEnabled = false
            
        } else {
            
            let person = people[indexPath.row]
            cell.nameLabel.text = person.name
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let peopleSet = group?.people,
            let peopleArray = Array(peopleSet) as? [Person] else { return }
        let person = peopleArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "PersonViewController") as! PersonViewController
        nextVC.person = person
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: SelectServiceTableViewCellDelegate funcion
    
    func personWasSelected(cell: SelectPersonTableViewCell) {
        
        guard let indexPath = peopleTableView.indexPath(for: cell) else { return }
        
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



























