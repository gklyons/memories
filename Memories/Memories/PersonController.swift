//
//  PersonController.swift
//  Memories
//
//  Created by Caleb Strong on 9/18/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class PersonController {
    
    fileprivate static let PersonKey = "people"
    
    static let shared = PersonController()
    
    // MARK: - Properties
    
    var people: [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    // MARK: - CRUD Functions
    
    func createPerson(name: String, photo: UIImage) {
        guard let photoData = UIImageJPEGRepresentation(photo, 1) as NSData? else { return }
        let _ = Person(name: name, photo: photoData, isSelected: false)
        saveToPersistentStore()
    }
    
    func deletePerson(person: Person) {
        if let moc = person.managedObjectContext {
            moc.delete(person)
            saveToPersistentStore()
        }
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("There was an error while saving to persistent store: \(error)")
        }
    }
}
