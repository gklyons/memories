//
//  GroupViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/20/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - IBOutlets
    
    @IBOutlet weak var groupTableView: UITableView!
    
    // MARK: - IBActions
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        guard let section = groupTableView.indexPathForSelectedRow else { return }
        let group = GroupController.shared.groups[section.row]
        GroupController.shared.deleteGroup(group: group)
        groupTableView.deleteSections(NSIndexSet(index: section.row) as IndexSet, with: .automatic)
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
        return GroupController.shared.groups.count
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let group = GroupController.shared.groups[section]
//        return group.name
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let group = GroupController.shared.groups[section]
        
        let headerButton = UIButton(type: .roundedRect)
        headerButton.setTitle(group.name, for: .normal)
        headerButton.setTitleColor(.black, for: .normal)
        
        let deleteButton = UIButton(type: .roundedRect)
        deleteButton.setTitle("-", for: .normal)
        deleteButton.backgroundColor = .red
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.addTarget(self, action: #selector(GroupViewController.deleteButtonTapped(_:)), for: .touchUpInside)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [headerButton, deleteButton])
        horizontalStackView.spacing = 8
        horizontalStackView.distribution = .fillProportionally
        
        return horizontalStackView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = GroupController.shared.groups[section]
        let people = group.people ?? []
        let peopleArray = Array(people)
        return peopleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let group = GroupController.shared.groups[indexPath.section]
        guard let people = group.people else { return UITableViewCell() }
        let peopleArray = Array(people)
        guard let person = peopleArray[indexPath.row] as? Person else { return UITableViewCell() }
    
        cell.textLabel?.text = person.name
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let group = GroupController.shared.groups[indexPath.section - 1]
//            GroupController.shared.deleteGroup(group: group)
//            let indexSet = IndexSet(arrayLiteral: indexPath.section)
//            groupTableView.deleteSections(indexSet, with: .automatic)
//        }
//    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
