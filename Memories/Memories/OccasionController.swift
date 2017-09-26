//
//  OccasionController.swift
//  Memories
//
//  Created by Garrett Lyons on 9/22/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class OccasionController {
    
    static let shared = OccasionController()
    
    // MARK - Properties
    
    var occasion: [Occasion] {
        let request: NSFetchRequest<Occasion> = Occasion.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    // MARK - CRUD
    
    func createOccasion(title: String) {
        let _ = Occasion(title: title)
        saveToPersistentStore()
    }
    
    func deleteOccasion(occasion: Occasion) {
        let moc = occasion.managedObjectContext
        moc?.delete(occasion)
        saveToPersistentStore()
    }
    
    // MARK - Persitence
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            NSLog("There was a problem saving to the persistent store: \(error)")
        }
    }
}
