//
//  GroupViewController.swift
//  Memories
//
//  Created by Caleb Strong on 9/20/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    
    var buttonTag: Int?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var groupTableView: UITableView!
    
    // MARK: - IBActions
    
    @objc func groupNameButtonTapped(_ sender: UIButton) {
        buttonTag = sender.tag
        performSegue(withIdentifier: "toNewGroupVC", sender: self)
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        let section = sender.tag
        let group = GroupController.shared.groups[section]
        GroupController.shared.deleteGroup(group: group)
        groupTableView.deleteSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let group = GroupController.shared.groups[section]
        
        let headerButton = UIButton(type: .roundedRect)
        headerButton.setTitle(group.name, for: .normal)
        headerButton.setTitleColor(.black, for: .normal)
        headerButton.tag = section
        headerButton.addTarget(self, action: #selector(GroupViewController.groupNameButtonTapped(_:)), for: .touchUpInside)
        
        let deleteButton = UIButton(type: .roundedRect)
        deleteButton.setTitle("-", for: .normal)
        deleteButton.backgroundColor = .red
        deleteButton.setTitleColor(.black, for: .normal)
        deleteButton.tag = section
        deleteButton.addTarget(self, action: #selector(GroupViewController.deleteButtonTapped(_:)), for: .touchUpInside)
        deleteButton.layer.cornerRadius = 10
        deleteButton.frame.size = CGSize(width: 50, height: 50)
        
        let horizontalStackView = UIStackView(arrangedSubviews: [headerButton, deleteButton])
        horizontalStackView.spacing = 8
        horizontalStackView.distribution = .fill
        
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













