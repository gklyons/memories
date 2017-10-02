//
//  GroupViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/20/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandableHeaderViewDelegate {
    
    // MARK: - Properties
    
    var buttonTag: Int?
    var groups: [Group]?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var groupTableView: UITableView!
    
    // MARK: - IBActions
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        let section = sender.tag
        let group = groups![section]
        
        let alert = UIAlertController(title: "Are you sure?", message: "You are going to delete \(group.name ?? "this group").", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let okayAction = UIAlertAction(title: "Okay", style: .default) { (uiAlertAction) in
            GroupController.shared.deleteGroup(group: group)
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        groupTableView.reloadData()
    }
    
    // MARK: - Table View Data Source Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.groups = GroupController.shared.groups
        return groups?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let groups = groups else { return UIView() }
        if groups.count != 0 {
            guard let group = self.groups?[section] else { return UIView() }
            
            let header = ExpandableHeaderView()
            header.customInit(title: group.name!, section: section, delegate: self)
        
            let deleteButton = UIButton(type: .roundedRect)
            deleteButton.setTitle("-", for: .normal)
            deleteButton.backgroundColor = .red
            deleteButton.setTitleColor(.black, for: .normal)
            deleteButton.tag = section
            deleteButton.addTarget(self, action: #selector(GroupViewController.deleteButtonTapped(_:)), for: .touchUpInside)
//            deleteButton.layer.cornerRadius = 10
            deleteButton.frame.size = CGSize(width: 50, height: 50)
            
            let horizontalStackView = UIStackView(arrangedSubviews: [header, deleteButton])
//            horizontalStackView.spacing = 8
            horizontalStackView.distribution = .fill
            
            return horizontalStackView
        } else {
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let groups = groups else { return 0 }
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
        guard let groups = groups else { return 0 }
        let group = groups[section]
        let people = group.people ?? []
        let peopleArray = Array(people)
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard let groups = groups else { return cell }
        let group = groups[indexPath.section]
        guard let people = group.people else { return UITableViewCell() }
        let peopleArray = Array(people)
        guard let person = peopleArray[indexPath.row] as? Person else { return UITableViewCell() }
        
        cell.textLabel?.text = person.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let group = groups![indexPath.row]
        guard let peopleSet = group.people,
            let peopleArray = Array(peopleSet) as? [Person] else { return }
        let person = peopleArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "PersonViewController") as! PersonViewController
        nextVC.person = person
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        guard let groups = groups else { return }
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
            let group = GroupController.shared.groups[buttonTag]
            let newGroupVC = segue.destination as? NewGroupViewController
            newGroupVC?.group = group
        }
    }
}













