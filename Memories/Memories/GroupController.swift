//
//  GroupController.swift
//  Memories
//
//  Created by Caleb Strong on 9/20/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData

class GroupController {
    
    static let shared = GroupController()
    
    // MARK: - Properties
    
    var groups: [Group] {
        let request: NSFetchRequest<Group> = Group.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    // MARK: CRUD Functions
    
    func createGroup(name: String, people: [Person]) {
        let setOfPeople = NSSet(array: people)
        let _ = Group(name: name, people: setOfPeople)
        PersonController.shared.saveToPersistentStore()
    }
    
    func updateGroup() {
        
    }
    
    func deleteGroup(group: Group) {
        if let moc = group.managedObjectContext {
            moc.delete(group)
            PersonController.shared.saveToPersistentStore()
        }
    }
    
    
    
    
    
    
    
}
