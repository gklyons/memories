//
//  GroupViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/20/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit
import CoreData

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {
    
    // MARK: - Fetched Results Controller
    
    let fetchedResultsController: NSFetchedResultsController<Group> = {
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name",ascending: true)]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest,
                                          managedObjectContext: CoreDataStack.context,
                                          sectionNameKeyPath: nil,
                                          cacheName: nil)
    }()
    
    // MARK: - Properties
    
    var buttonTag: Int?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var groupTableView: UITableView!
    
    // MARK: - IBActions
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        let section = sender.tag
        let group = fetchedResultsController.fetchedObjects![section]
        
        let alert = UIAlertController(title: "Are you sure?", message: "You are going to delete \(group.name ?? "this group").", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (uiAlertAction) in
            if let group = self.fetchedResultsController.fetchedObjects?[section] {
                GroupController.shared.deleteGroup(group: group)
            }
            self.groupTableView.deleteSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
            self.groupTableView.reloadData()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
        fetchedResultsController.delegate = self
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error starting fetched results controller: \(error)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        groupTableView.reloadData()
    }
    
    // MARK: - Table View Data Source Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let groups = fetchedResultsController.fetchedObjects else { return UIView() }
        if groups.count != 0 {
            let group = groups[section]
            
            let header = ExpandableHeaderView()
            header.customInit(title: group.name!, section: section, delegate: self)
        
            let deleteButton = UIButton(type: .roundedRect)
            deleteButton.setTitle("-", for: .normal)
            deleteButton.backgroundColor = .red
            deleteButton.setTitleColor(.black, for: .normal)
            deleteButton.tag = section
            deleteButton.addTarget(self, action: #selector(GroupViewController.deleteButtonTapped(_:)), for: .touchUpInside)
//            deleteButton.layer.cornerRadius = 10
            deleteButton.frame.size = CGSize(width: 44, height: 44)
            
            let horizontalStackView = UIStackView(arrangedSubviews: [header, deleteButton])
//            horizontalStackView.spacing = 8
            horizontalStackView.distribution = .fillProportionally
            
            return horizontalStackView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let groups = fetchedResultsController.fetchedObjects else { return 0 }
        if (groups[indexPath.section].isExpanded == true) {
            return 44
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let groups = fetchedResultsController.fetchedObjects else { return 0 }
        let group = groups[section]
        let people = group.people ?? []
        let peopleArray = Array(people)
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard let groups = fetchedResultsController.fetchedObjects else { return cell }
        let group = groups[indexPath.section]
        guard let people = group.people else { return UITableViewCell() }
        let peopleArray = Array(people)
        guard let person = peopleArray[indexPath.row] as? Person else { return UITableViewCell() }
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let group = fetchedResultsController.fetchedObjects![indexPath.row]
        guard let peopleSet = group.people,
            let peopleArray = Array(peopleSet) as? [Person] else { return }
        let person = peopleArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "PersonViewController") as! PersonViewController
        nextVC.person = person
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        guard let groups = fetchedResultsController.fetchedObjects else { return }
        groups[section].isExpanded = !groups[section].isExpanded
        guard let people = groups[section].people else { return }
        groupTableView.beginUpdates()
        for row in 0 ..< people.count {
            groupTableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        groupTableView.endUpdates()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewGroupVC" {
            guard let buttonTag = buttonTag else { return }
            let group = fetchedResultsController.fetchedObjects![buttonTag]
            let newGroupVC = segue.destination as? NewGroupViewController
            newGroupVC?.group = group
        }
    }
}

// MARK: - NSFetchedResultsController

extension GroupViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
//            groupTableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
//            groupTableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            groupTableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
//            groupTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}











