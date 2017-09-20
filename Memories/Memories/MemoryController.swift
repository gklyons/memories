//
//  MemoryController.swift
//  Memories
//
//  Created by Caleb Strong on 9/18/17.
//  Copyright © 2017 Garrett Lyons. All rights reserved.
//

import Foundation
import UIKit

class MemoryController {
    
    // MARK: - CRUD Functions
    
    static func createMemory(title: String, memoryInfo: String, timestamp: Date = Date(), person: Person) {
        let _ = Memory(title: title, memoryInfo: memoryInfo, timestamp: timestamp, person: person)
        PersonController.shared.saveToPersistentStore()
    }
    
    static func deleteMemory(memory: Memory) {
        if let moc = memory.managedObjectContext {
            moc.delete(memory)
            PersonController.shared.saveToPersistentStore()
        }
    }
    
    
}
